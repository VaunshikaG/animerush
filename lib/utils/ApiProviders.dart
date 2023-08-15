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
  var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6IkFuaW1lUnVzaF92YXVuc2hpa2EiLCJleHAiOjE2OTE1NjUyMDEsImVtYWlsIjoidmF1bnNoaWthZ29nYXJrYXJAZ21haWwuY29tIn0.SKndAX2Fheggdlg8CvZlqvUshzkJ7FBmvzpoYwCMXE4";

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
      throw Exception("Error while fetching the data");
    }
  }

  Future<String> loginApi({required LoginModel model}) async {
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

  Future<String> signUpApi({required SignUpModel model}) async {
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

  Future<String> otpVerfiyApi({required OtpVerfiyModel model}) async {
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

  Future<String> forgotPasswordApi({required String email}) async {
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

  Future<String> changePasswordApi({required ChangePasswordModel model}) async {
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

  Future<String> profilePasswordApi({required ProfilePasswordModel model}) async {
    Uri myUri = Uri.parse(AppConst.userFun);

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

  Future<String> homeApi() async {
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

  Future<String> detailsApi() async {
  // Future<String> DetailsApi({required String animeId}) async {
  //   Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/a77d04bc-1780-4ad4-8770-b234bf25a04b");

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

  Future<String> episodeApi() async {
  // Future<String> EpisodeApi({required String episodeId}) async {
  //   Uri myUri = Uri.parse(AppConst.details);
    Uri myUri = Uri.parse("https://mocki.io/v1/ce176c4c-17dc-4900-af42-280965fee3b3");

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

  Future<String> searchApi() async {
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

  Future<String> watchListApi() async {
  // Future<String> WatchListApi({required String type}) async {
  //   Uri myUri = Uri.parse(AppConst.watchList);
    Uri myUri = Uri.parse("https://mocki.io/v1/7ad7e981-f972-456f-bd16-646ffd674ea4");
    // Uri myUri = Uri.parse("https://mocki.io/v1/bde73b40-ac75-4e7d-9779-8a8a8a4bd503");
    // Uri myUri = Uri.parse("https://mocki.io/v1/45a7acdb-209e-465a-bfa5-79bcb6c00f75");

    Map<String, dynamic> jsonMap = {
      'function_name': 'watch_list',
      // 'type': type,
    };

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

  Future<String> addToListApi() async {
  // Future<String> addToListApi({required String type, required String animeId}) async {
    //   Uri myUri = Uri.parse(AppConst.addWatch);
    Uri myUri = Uri.parse("https://mocki.io/v1/7ad7e981-f972-456f-bd16-646ffd674ea4");

    // Map<String, dynamic> jsonMap = {
    //   'anime': animeId,
    //   'type': type,
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

  Future<String> continueApi() async {
  // Future<String> ContinueApi({required String type}) async {
  //   Uri myUri = Uri.parse(AppConst.watchList);
    Uri myUri = Uri.parse("https://mocki.io/v1/0ec4af33-948d-4ef8-b5f2-6157883466ce");

    Map<String, dynamic> jsonMap = {
      'function_name': 'continue_watching',
      // 'type': type,
    };

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

}