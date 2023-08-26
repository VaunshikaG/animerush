import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../utils/theme.dart';

ProgressDialog? progressDialog;

showProgress(BuildContext context, bool isDismissible) async {
  progressDialog = ProgressDialog(
    context,
    type: ProgressDialogType.normal,
    isDismissible: isDismissible,
    customBody: SizedBox(
      height: 55,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: RefreshProgressIndicator(
          backgroundColor: const Color(0xFF333A44),
          color: CustomTheme.themeColor1,
        ),
      ),
    ),
  );
  progressDialog?.style(
    message: '',
    borderRadius: 0,
    backgroundColor: const Color(0xFF000000),
    elevation: 0,
    insetAnimCurve: Curves.easeInOut,
  );
  await progressDialog?.show();
}

updateProgress(String message) {
  progressDialog?.update(message: message);
}

hideProgress() async {
  if (progressDialog != null) await progressDialog?.hide();
}
