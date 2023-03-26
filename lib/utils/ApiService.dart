import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../widgets/CustomToast.dart';
import 'AppConst.dart';
import 'Loader.dart';

class APIService {
  Future<String> HomeApi() async {
    Uri myUri = Uri.parse(AppConst.home);
    // Uri myUri = Uri.parse("https://mocki.io/v1/a8900414-01fe-4d28-95d2-c7c6a74d3042");

    Map<String, String> jsonMap = {'key': AppConst.KEY};

    try {
      return http.post(
        myUri,
        // body: jsonMap,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400) {
          throw Exception("Error while fetching the data");
        }
        return response.body;
      });
    } catch (e) {
      hideProgress();
      if (e is SocketException) {
        CustomToast("Please check your internet connection");
      } else if (e is TimeoutException) {
        CustomToast("TimeoutException");
      } else {
        CustomToast("Unhandled Exception");
      }
      rethrow;
    }
  }

  Future<String> DetailsApi() async {
  // Future<String> DetailsApi({required String animeId}) async {
    // Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/b4a89a45-6358-4b22-9220-dd08dd604ba8");

    var map = <String, dynamic>{};
    map['key'] = AppConst.KEY;
    // map['id'] = animeId;

    try {
      return http.get(
        myUri,
        // body: map,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400) {
          throw Exception("Error while fetching the data");
        }
        return response.body;
      });
    } catch (e) {
      hideProgress();
      if (e is SocketException) {
        CustomToast("Please check your internet connection");
      } else if (e is TimeoutException) {
        CustomToast("TimeoutException");
      } else {
        CustomToast("Unhandled Exception");
      }
      rethrow;
    }
  }

  Future<String> EpisodeApi() async {
  // Future<String> EpisodeApi({required String animeId}) async {
  //   Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/f1760b19-64fa-4c98-8092-0fc9348cc33e");

    var map = <String, dynamic>{};
    map['key'] = AppConst.KEY;
    // map['id'] = animeId;

    try {
      return http.get(
        myUri,
        // body: map,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400) {
          throw Exception("Error while fetching the data");
        }
        return response.body;
      });
    } catch (e) {
      hideProgress();
      if (e is SocketException) {
        CustomToast("Please check your internet connection");
      } else if (e is TimeoutException) {
        CustomToast("TimeoutException");
      } else {
        CustomToast("Unhandled Exception");
      }
      rethrow;
    }
  }
}