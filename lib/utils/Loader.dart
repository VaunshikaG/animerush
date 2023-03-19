// import 'package:flutter/material.dart';
// import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
//
// ProgressDialog? progressDialog;
//
// showProgress(BuildContext context, String message, bool isDismissible) async {
//   progressDialog = ProgressDialog(context,
//       type: ProgressDialogType.normal, isDismissible: isDismissible);
//   progressDialog?.style(
//     message: message,
//     borderRadius: 10,
//     backgroundColor: CustomTheme.white,
//     progressWidget: Container(
//         padding: const EdgeInsets.all(8),
//         child: const CircularProgressIndicator(backgroundColor: CustomTheme.white),
//     ),
//     elevation: 10,
//     insetAnimCurve: Curves.easeInOut,
//     messageTextStyle: const TextStyle(
//       color: CustomTheme.black,
//       fontSize: 15,
//     ),
//   );
//   await progressDialog?.show();
// }
//
// updateProgress(String message) {
//   progressDialog?.update(message: message);
// }
//
// hideProgress() async {
//   if (progressDialog != null) await progressDialog?.hide();
// }
