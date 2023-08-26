import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/commonStyle.dart';
import '../utils/theme.dart';
import 'customButtons.dart';

Widget? loginSheet({
  appTheme,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller1,
  required TextEditingController controller2,
  required bool showPassword,
  required void Function() onPressed1,
  required void Function() onPressed2,
  required void Function() onPressed3,
}) {
  // final _formKey1 = GlobalKey<FormState>();
  // bool showPassword = true;
  Get.bottomSheet(
    Container(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                "Login Your Account",
                style: appTheme.textTheme.displayLarge,
              ),
              const SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill this field';
                  }
                  return null;
                },
                controller: controller1,
                cursorColor: appTheme.scaffoldBackgroundColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                style: appTheme.textTheme.headlineSmall,
                decoration: CommonStyle.email_textFieldStyle(
                  style: appTheme.textTheme.headlineSmall!,
                  labelText: "name@email.com",
                  hintText: "name@email.com",
                ),
              ),
              const SizedBox(height: 30),
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
                controller: controller2,
                cursorColor: appTheme.scaffoldBackgroundColor,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                style: appTheme.textTheme.headlineSmall,
                decoration: CommonStyle.password_textFieldStyle(
                  style: appTheme.textTheme.headlineSmall!,
                  labelText: "Enter your password",
                  hintText: "Enter your password",
                  suffix: IconButton(
                    onPressed: () => showPassword = !showPassword,
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
                text: 'Login',
                onPressed: onPressed1,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: appTheme.textTheme.bodySmall,
                  ),
                  textButton(
                    text: 'Register',
                    onPressed: onPressed2,
                  ),
                ],
              ),
              textButton(
                text: 'Forgot Password',
                onPressed: onPressed3,
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: appTheme.disabledColor,
    // elevation: 5,
    isDismissible: true,
    enableDrag: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
