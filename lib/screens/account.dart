import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/accountController.dart';
import '../controllers/loginController.dart';
import '../controllers/searchController.dart';
import '../controllers/versionController.dart';
import '../controllers/watchListController.dart';
import '../utils/appConst.dart';
import '../utils/commonStyle.dart';
import '../utils/theme.dart';
import '../widgets/customButtons.dart';
import '../widgets/loader.dart';
import '../widgets/noData.dart';
import 'details.dart';
import 'splash.dart';
import 'auth.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  VersionController versionController = Get.put(VersionController());
  AccountController accountController = Get.put(AccountController());
  List<DownloadTask> downloadedTasks = [];

  final _formKey6 = GlobalKey<FormState>();
  TabController? _controller;
  bool showPassword = true;

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    // loadDownloadedTasks();
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, true);
    accountController.profileApi();
  }

  Future<void> loadDownloadedTasks() async {
    downloadedTasks.clear();
    List<DownloadTask> allTasks = (await FlutterDownloader.loadTasks())!;
    setState(() {
      if (allTasks.isNotEmpty) {
        downloadedTasks = allTasks.where((task) =>
        task.status == DownloadTaskStatus.complete || task.status == DownloadTaskStatus.running).toList();
        // downloadedTasks = (await FlutterDownloader.loadTasks())!;
        log('dwldList : ${downloadedTasks.length.toString()}');
      }
      hideProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Visibility(
                visible: accountController.hasData.value,
                child: DefaultTabController(
                  length: 2,
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                        child: TabBar(
                          controller: _controller,
                          automaticIndicatorColorAdjustment: true,
                          isScrollable: true,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                          onTap: (index) {
                            if (index == 1) {
                              accountController.continueApi();
                            }
                            // else if (index == 2) {
                            //   loadDownloadedTasks();
                            // }
                          },
                          tabs: [
                            Tab(
                              height: 35,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: const Center(
                                  child: Text("Profile"),
                                ),
                              ),
                            ),
                            Tab(
                              height: 35,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: const Center(
                                  child: Text("Continue Watching"),
                                ),
                              ),
                            ),
                            // Tab(
                            //   height: 35,
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.symmetric(horizontal: 20),
                            //     child: const Center(
                            //       child: Text("Downloads"),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.82,
                        child: TabBarView(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            profile(),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                Obx(() => Visibility(
                                  visible: accountController.hasData.value,
                                  child: continueWatch(),
                                )),
                                Obx(() => Visibility(
                                  visible: accountController.noData.value,
                                  child: noData("Oops, failed to load data!"),
                                )),
                              ],
                            ),
                            // downloads(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Obx(() => Visibility(
                visible: accountController.noData.value,
                child: noData("Oops, failed to load data!"),
              )),
              Obx(() => Visibility(
                visible: accountController.showLogin.value,
                child: Center(
                  heightFactor: 13,
                  child: elevatedButton(
                    text: "Login →",
                    onPressed: () => Get.offAll(() => const Auth()),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: appTheme.scaffoldBackgroundColor,
                child: Image.asset(
                  "assets/img/profile.png",
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            customTile(text1: 'EMAIL ADDRESS', text2: accountController.email),
            customTile(text1: 'EMAIL USERNAME', text2: accountController.userName),
            customTile(text1: 'DATE JOINED', text2: accountController
                .dateJoined),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ExpansionTile(
                leading: Icon(
                  Icons.key,
                  color: appTheme.iconTheme.color,
                ),
                title: Text(
                  'Change password',
                  style: appTheme.textTheme.titleSmall,
                ),
                children: [
                  Form(
                    key: _formKey6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "CURRENT PASSWORD",
                          style: appTheme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          controller: accountController.passwordController,
                          cursorColor: appTheme.scaffoldBackgroundColor,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          style: appTheme.textTheme.headlineSmall,
                          decoration: CommonStyle.email_textFieldStyle(
                            style: appTheme.textTheme.headlineSmall!,
                            labelText: "Current Password",
                            hintText: "Current Password",
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "NEW PASSWORD",
                          style: appTheme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp passRegExp = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                              // } else if (!passRegExp.hasMatch(value)) {
                              //   return 'Password is not strong';
                            }
                            return null;
                          },
                          obscureText: showPassword,
                          controller: accountController.newPasswordController,
                          cursorColor: appTheme.scaffoldBackgroundColor,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          style: appTheme.textTheme.headlineSmall,
                          decoration: CommonStyle.password_textFieldStyle(
                            style: appTheme.textTheme.headlineSmall!,
                            labelText: "New Password",
                            hintText: "New Password",
                            suffix: IconButton(
                              onPressed: () =>
                                  setState(() => showPassword = !showPassword),
                              icon: showPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              color: CustomTheme.black,
                              iconSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        elevatedButton(
                          text: 'Save',
                          onPressed: () async {
                            if (_formKey6.currentState!.validate()) {
                              if (!FocusScope.of(context).hasPrimaryFocus) {
                                FocusScope.of(context).unfocus();
                              }
                              _formKey6.currentState!.save();
                              await showProgress(context, true);
                              accountController.profilePasswordApi();
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 10),
              constraints: const BoxConstraints(maxWidth: 120),
              child: ListTile(
                onTap: () async {
                  // loginController.isLoggedIn.value = true;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Get.deleteAll();
                  Get.offAll(() => const Splash());
                },
                leading: Icon(
                  Icons.logout,
                  size: 19,
                  color: appTheme.iconTheme.color,
                ),
                title: Text(
                  'Logout',
                  style: appTheme.textTheme.titleSmall,
                ),
                tileColor: appTheme.colorScheme.surface,
                visualDensity: const VisualDensity(vertical: -4),
                minLeadingWidth: 5,
              ),
            ),
            Center(
              child: Text(
                // 'App version 0.0.1',
                'App version ${versionController.packageInfo!.version}',
                style: appTheme.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget continueWatch() {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 140,
            ),
            itemCount: accountController.continueList.length,
            itemBuilder: (BuildContext ctx, index) {
              final continueList = accountController.continueList[index];
              final lang;

              if (continueList.anime!.type == 'S') {
                lang = "SUB";
              } else if (continueList.anime!.type == 'D') {
                lang = "DUB";
              } else {
                lang = "-";
              }

              return GestureDetector(
                onTap: () {
                  Get.offAll(() => Details(
                      id: continueList.anime!.id.toString(), epId: continueList
                      .episode!.replaceAll('.0', '').toString()));
                },
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  // decoration: BoxDecoration(color: CustomTheme.grey300),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInImage.assetNetwork(
                            alignment: Alignment.center,
                            placeholder: "assets/img/blank.png",
                            image: continueList.anime!.aniImage ??
                                continueList.anime!.imageHighQuality!,
                            fit: BoxFit.fill,
                            height: 230,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/img/blank.png",
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5, top: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (lang == "SUB")
                                  ? appTheme.indicatorColor
                                  : appTheme.colorScheme.error,
                            ),
                            child: Text(
                              lang,
                              style: appTheme.textTheme.labelSmall,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              continueList.anime!.name ?? "",
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: appTheme.textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              "Watching Ep  :   ${continueList.episode}",
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: appTheme.textTheme.titleSmall,
                            ),
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                            visualDensity: const VisualDensity(vertical: -4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
      ],
    );
  }

  Widget downloads() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: (downloadedTasks.isNotEmpty)
          ? ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: downloadedTasks.length,
              itemBuilder: (context, index) {
                DownloadTask task = downloadedTasks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: appTheme.iconTheme.color,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await FlutterDownloader.remove(
                          taskId: task.taskId,
                          shouldDeleteContent: true,
                        );
                        setState(() {
                          loadDownloadedTasks();
                        });
                      },
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: appTheme.colorScheme.error,
                        size: 20,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    title: Text(
                      task.filename.toString(),
                      style: appTheme.textTheme.titleSmall,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    subtitle: (task.status == DownloadTaskStatus.running)
                        ? Obx(() => LinearProgressIndicator(value:
                    downloadedTasks[index].progress / 100))
                        : (task.status == DownloadTaskStatus.failed) ? Text('Failed',
                      style: appTheme.textTheme.titleSmall,
                    ) : const SizedBox(),
                    onTap: () async {
                      await FlutterDownloader.open(taskId: task.taskId);
                    },
                    // dense: true,
                    visualDensity: const VisualDensity(vertical: -4),
                    tileColor: appTheme.hintColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                );
              },
            )
          : const Center(child: Text('No downloads yet')),
    );
  }
}


