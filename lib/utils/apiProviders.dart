// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/rqModels.dart';
import '../widgets/customSnackbar.dart';
import 'appConst.dart';
import '../widgets/loader.dart';
import 'localStorge.dart';

class ApiProviders {
  // var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6IkFuaW1lUnVzaF92YXVuc2hpa2EiLCJleHAiOjE2OTMzMTI4NDUsImVtYWlsIjoidmF1bnNoaWthZ29nYXJrYXJAZ21haWwuY29tIn0.16Ljn74yBJHLJYjD61AcV1jLIoyh8BZq9-2zU8Z1igo";

  void catchExp(Object e) {
    hideProgress();
    if (e is SocketException) {
      CustomSnackBar("Please check your internet connection");
    } else if (e is TimeoutException) {
      CustomSnackBar("TimeoutException");
    } else {
      CustomSnackBar("Unhandled Exception");
    }
  }

  void statusExp(int statusCode) {
    if (statusCode < 200 || statusCode > 401) {
      hideProgress();
      CustomSnackBar("Error $statusCode while fetching the data.");
      throw Exception("Error while fetching the data");
    }
  }

  Future<String> appVersionApi() async {
    final prefs = await SharedPreferences.getInstance();
    Uri myUri = Uri.parse(AppConst.verion);

    try {
      return http.get(myUri).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> loginApi({required LoginModel model}) async {
    Uri myUri = Uri.parse(AppConst.login);

    try {
      return http
          .post(
        myUri,
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> signUpApi({required SignUpModel model}) async {
    Uri myUri = Uri.parse(AppConst.signUp);

    try {
      return http
          .post(
        myUri,
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> otpVerfiyApi({required OtpVerfiyModel model}) async {
    Uri myUri = Uri.parse(AppConst.otpVerify);

    try {
      return http
          .post(
        myUri,
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> forgotPasswordApi({required String email}) async {
    Uri myUri = Uri.parse(AppConst.forgotPassword);

    Map<String, String> requestBody = <String, String>{
      'email': '$email',
      "web_code": "AnimeRush",
    };

    try {
      return http
          .post(
        myUri,
        body: requestBody,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> changePasswordApi({required ChangePasswordModel model}) async {
    Uri myUri = Uri.parse(AppConst.changePassword);

    try {
      return http
          .post(
        myUri,
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> profilePasswordApi(
      {required ProfilePasswordModel model}) async {
    Uri myUri = Uri.parse(AppConst.userFun);

    try {
      return http
          .post(
        myUri,
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> homeApi() async {
    Uri myUri = Uri.parse(AppConst.home);

    Map<String, String> jsonMap = {'key': AppConst.KEY};

    try {
      return http
          .post(
        myUri,
        body: jsonMap,
      )
          .then((http.Response response) async {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        // Store JSON data
        await HomeStorage().storeHomeData(response.body);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> DetailsApi({required String animeId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.details);

    Map<String, String> jsonMap = {
      'key': AppConst.KEY,
      'id': animeId,
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> EpisodeApi({required String episodeId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.episode);

    Map<String, String> jsonMap = {
      'key': AppConst.KEY,
      'id': episodeId,
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> SearchApi({required SearchModel model}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.search);

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: model.toJson(),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> WatchListApi({required String type}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.userFun);

    Map<String, dynamic> jsonMap = {
      'function_name': 'watch_list',
      'type': type,
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> AddToListApi(
      {required String type, required String animeId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.addWatch);

    Map<String, dynamic> jsonMap = {
      'anime': animeId,
      'type': type,
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> ContinueApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.userFun);

    Map<String, dynamic> jsonMap = {
      'function_name': 'continue_watching',
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> ProfileApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConst.token) ?? "";
    Uri myUri = Uri.parse(AppConst.userFun);

    Map<String, dynamic> jsonMap = {
      'function_name': 'profile_details',
    };

    try {
      return http
          .post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      )
          .then((http.Response response) async {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        // Store JSON data
        await ProfileStorage().storeProfile(response.body);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }
}
