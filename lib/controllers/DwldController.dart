import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DwldController {
  List<TaskInfo>? taskInfo;
  List<ItemHolder>? items;
  List<DownloadItem>? dwldList;
  bool? showContent;
  bool? permissionReady;
  bool? saveInPublicStorage = false;
  String? localPath;
  final ReceivePort port = ReceivePort();
  var folderName = "AnimeRush";

  void bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      const status = DownloadTaskStatus.running;
      final progress = data[2] as int;

      print(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (taskInfo != null && taskInfo!.isNotEmpty) {
        final task = taskInfo!.firstWhere((task) => task.taskId == taskId);
        task
          ..status = status
          ..progress = progress;
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    log(
      'Callback on background isolate: task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<void> retryRequestPermission() async {
    final hasGranted = await checkPermission();

    if (hasGranted) {
      await prepareSaveDir();
    }

    permissionReady = hasGranted;
  }

  Future<void> requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
      },
      savedDir: 'storage/emulated/0/$folderName',
      saveInPublicStorage: saveInPublicStorage!,
      fileName: "${task.name}.mp4",
    );
  }

  Future<void> retryDownload(TaskInfo task) async {
    final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<bool> openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }

  // to delete
  Future<void> delete(TaskInfo task) async {
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    );
    await prepare();
  }

  Future<void> prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      print('No tasks were retrieved from the database.');
      return;
    }

    var count = 0;
    taskInfo = [];
    items = [];

    taskInfo!.addAll(
      dwldList!.map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    items!.add(ItemHolder(name: 'Videos'));
    for (var i = count; i < taskInfo!.length; i++) {
      items!.add(ItemHolder(name: taskInfo![i].name, task: taskInfo![i]));
      count++;
    }

    for (final task in tasks) {
      for (final info in taskInfo!) {
        if (info.link == task.url) {
          info
            ..taskId = task.taskId
            ..status = task.status
            ..progress = task.progress;
        }
      }
    }

    permissionReady = await checkPermission();
    if (permissionReady!) {
      await prepareSaveDir();
    }

    showContent = true;
  }

  Future<void> prepareSaveDir() async {
    localPath = (await getSavedDir())!;
    final savedDir = Directory(localPath!);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> getSavedDir() async {
    var externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await getDownloadsDirectory();
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  void onActionTap(task) {
    if (task.status == DownloadTaskStatus.undefined) {
      requestDownload(task);
    } else if (task.status == DownloadTaskStatus.complete ||
        task.status == DownloadTaskStatus.canceled) {
      delete(task);
    } else if (task.status == DownloadTaskStatus.failed) {
      retryDownload(task);
    }
  }
}

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;
}

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}

class DownloadItem {
  const DownloadItem({required this.name, required this.url});

  final String name;
  final String url;
}
