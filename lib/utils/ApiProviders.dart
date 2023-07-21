import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/RqModels.dart';
import '../widgets/CustomSnackbar.dart';
import 'AppConst.dart';
import '../widgets/Loader.dart';

class ApiProviders {
  var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6IkFuaW1lUnVzaF92YXVuc2hpa2EiLCJleHAiOjE2OTAwMTA3MzIsImVtYWlsIjoidmF1bnNoaWthZ29nYXJrYXJAZ21haWwuY29tIn0.879sbT1ekJCpDL1Z96-5lXed8P7zOW2WcLy7ZfXZPlk";

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

    log(model.toJson().toString());
    try {
      return http.post(
        myUri,
        body: model.toJson(),
      ).then((http.Response response) {
        final int statusCode = response.statusCode;
        log(response.body);
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

    try {
      return http.post(
        myUri,
        body: model.toJson(),
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

    try {
      return http.post(
        myUri,
        body: model.toJson(),
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

    try {
      return http.post(
        myUri,
        body: model.toJson(),
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
    // Uri myUri = Uri.parse(AppConst.home);
    Uri myUri = Uri.parse("https://mocki.io/v1/79e0e726-396d-4c05-b355-65b792cd4415");

    Map<String, String> jsonMap = {'key': AppConst.KEY};

    try {
      return http.get(
      // return http.post(
        myUri,
        // body: jsonMap,
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

  Future<String> DetailsApi() async {
  // Future<String> DetailsApi({required String animeId}) async {
  //   Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/90beb7d1-1b20-4ed2-9c19-182ab52eb88f");

    // Map<String, String> jsonMap = {
    //   'key': AppConst.KEY,
    //   'id': animeId,
    // };

    try {
      return http.get(
      // return http.post(
        myUri,
        // headers: <String, String>{
        //   'Authorization': 'JWT $token',
        // },
        // body: jsonMap,
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

  Future<String> EpisodeApi() async {
  // Future<String> EpisodeApi({required String episodeId}) async {
  //   Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/009e0142-f8fe-4f21-9585-36f0f3317577");

    // Map<String, String> jsonMap = {
    //   'key': AppConst.KEY,
    //   'id': episodeId,
    // };

    try {
      return http.get(
      // return http.post(
        myUri,
        // headers: <String, String>{
        //   'Authorization': 'JWT $token',
        // },
        // body: jsonMap,
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

  Future<String> SearchApi() async {
  // Future<String> SearchApi({required SearchModel model}) async {
  //   Uri myUri = Uri.parse(AppConst.search);
    Uri myUri = Uri.parse("https://mocki.io/v1/1f975f19-6d43-49f3-8861-5a791d4ce71c");

    try {
      return http.get(
      // return http.post(
        myUri,
        // headers: <String, String>{
        //   'Authorization': 'JWT $token',
        // },
        // body: model.toJson(),
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

  // Future<String> WatchListApi() async {
  Future<String> WatchListApi({required String type}) async {
    Uri myUri = Uri.parse(AppConst.watchList);
  //   Uri myUri = Uri.parse("https://mocki.io/v1/7ad7e981-f972-456f-bd16-646ffd674ea4");
    // Uri myUri = Uri.parse("https://mocki.io/v1/bde73b40-ac75-4e7d-9779-8a8a8a4bd503");
    // Uri myUri = Uri.parse("https://mocki.io/v1/45a7acdb-209e-465a-bfa5-79bcb6c00f75");

    Map<String, dynamic> jsonMap = {
      'function_name': 'watch_list',
      'type': type,
    };

    try {
      // return http.get(
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