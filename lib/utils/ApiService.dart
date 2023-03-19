// import 'Constants.dart';
//
// class ApiService {
//   Future<String> HomeApi(String key) async {
//     Uri myUri = Uri.parse(AppConst.home);
//
//     try {
//       return http.post(
//         myUri,
//         body: requestModel.toJson(),
//       ).then((http.Response response) {
//         final int statusCode = response.statusCode;
//         if (statusCode < 200 || statusCode > 400) {
//           throw Exception("Error while fetching the data");
//         }
//         return response.body;
//       });
//     } catch (e) {
//       hideProgress();
//       if (e is SocketException) {
//         CustomToast("Please check your internet connection");
//       } else if (e is TimeoutException) {
//         CustomToast("TimeoutException");
//       } else {
//         CustomToast("Unhandled Exception");
//       }
//       rethrow;
//     }
//   }
// }