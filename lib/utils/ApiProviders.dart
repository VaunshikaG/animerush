import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/login/LoginPodo.dart';
import '../model/login/RqModels.dart';
import '../widgets/CustomSnackbar.dart';
import '../widgets/CustomToast.dart';
import 'AppConst.dart';
import '../widgets/Loader.dart';

class ApiProviders {
  var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0NiwidXNlcm5hbWUiOiJBbmltZVJ1c2hfYW5pbWVydXNoMTAiLCJleHAiOjE2ODk1ODY5NDcsImVtYWlsIjoicnRlajU1MDhAZ21haWwuY29tIn0.i012UMfDldkkyxrAzznXqr-_Mol0sbIyibgxDaHUgMk";

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
    if (statusCode < 200 || statusCode > 400) {
      throw Exception("Error while fetching the data");
    }
  }

  Future<String> LoginApi({required LoginModel model}) async {
    Uri myUri = Uri.parse(AppConst.login);
    // Uri myUri = Uri.parse();

    try {
      return http.post(
        myUri,
        body: jsonEncode(model),
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> SignUpApi({required SignUpModel model}) async {
    Uri myUri = Uri.parse(AppConst.signUp);
    // Uri myUri = Uri.parse();

    try {
      return http.post(
        myUri,
        body: jsonEncode(model),
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> OtpVerfiyApi({required OtpVerfiyModel model}) async {
    Uri myUri = Uri.parse(AppConst.otpVerify);
    // Uri myUri = Uri.parse();

    try {
      return http.post(
        myUri,
        body: jsonEncode(model),
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> ForgotPasswordApi({required String email}) async {
    Uri myUri = Uri.parse(AppConst.forgotPassword);
    // Uri myUri = Uri.parse();
    Map<String, String> requestBody = <String, String>{
      'email': '$email',
      "web_code": "AnimeRush",
    };

    try {
      return http.post(
        myUri,
        body: requestBody,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> ChangePasswordApi({required ChangePasswordModel model}) async {
    Uri myUri = Uri.parse(AppConst.changePassword);
    // Uri myUri = Uri.parse();

    try {
      return http.post(
        myUri,
        body: model,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  Future<String> HomeApi() async {
    Uri myUri = Uri.parse(AppConst.home);

    Map<String, String> jsonMap = {'key': AppConst.KEY};

    try {
      return http.post(
        myUri,
        body: jsonMap,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  // Future<String> DetailsApi() async {
  Future<String> DetailsApi({required String animeId}) async {
    Uri myUri = Uri.parse(AppConst.details);
    // Uri myUri = Uri.parse("https://mocki.io/v1/b4a89a45-6358-4b22-9220-dd08dd604ba8");

    Map<String, String> jsonMap = {
      'key': AppConst.KEY,
      'id': animeId,
    };
    var map = <String, dynamic>{};
    map['key'] = AppConst.KEY;
    map['id'] = animeId;

    try {
      return http.post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        print(statusCode);
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

  // Future<String> EpisodeApi() async {
  Future<String> EpisodeApi({required String episodeId}) async {
    Uri myUri = Uri.parse(AppConst.details);
    // Uri myUri = Uri.parse("https://mocki.io/v1/f1760b19-64fa-4c98-8092-0fc9348cc33e");

    var map = <String, dynamic>{};
    map['key'] = AppConst.KEY;
    map['id'] = episodeId;

    Map<String, String> jsonMap = {
      'key': AppConst.KEY,
      'id': episodeId,
    };

    try {
      return http.post(
        myUri,
        headers: <String, String>{
          'Authorization': 'JWT $token',
        },
        body: jsonMap,
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        statusExp(statusCode);
        return response.body;
      });
    } catch (e) {
      catchExp(e);
      rethrow;
    }
  }

}