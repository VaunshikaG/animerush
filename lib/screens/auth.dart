import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/loginController.dart';
import '../utils/commonStyle.dart';
import '../utils/theme.dart';
import '../widgets/customButtons.dart';
import '../widgets/loader.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  LoginController loginController = Get.put(LoginController());

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();

  bool showPassword = true, showLog = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      'assets/img/white_logo.png',
                      height: 70,
                    ),
                  ),

                  //  login
                  Obx(() => Visibility(
                        visible: loginController.isLogin.value,
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Login Your Account",
                                style: appTheme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "EMAIL OR USERNAME",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill this field';
                                  }
                                  return null;
                                },
                                controller: loginController.userNameController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "name@email.com",
                                  hintText: "name@email.com",
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "PASSWORD",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                controller: loginController.passwordController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.password_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "Password",
                                  hintText: "Password",
                                  suffix: IconButton(
                                    onPressed: () => setState(
                                        () => showPassword = !showPassword),
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
                                onPressed: () async {
                                  if (_formKey1.currentState!.validate()) {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                    }
                                    _formKey1.currentState!.save();
                                    await showProgress(context, true);
                                    loginController.loginApi();
                                  }
                                },
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
                                    onPressed: () {
                                      setState(() {
                                        if (!FocusScope.of(context)
                                            .hasPrimaryFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        loginController.isLogin.value = false;
                                        loginController.isSignin.value = true;
                                        loginController.userNameController
                                            .clear();
                                        loginController.emailController.clear();
                                        loginController.passwordController
                                            .clear();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              textButton(
                                text: 'Forgot Password',
                                onPressed: () {
                                  setState(() {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                    }
                                    loginController.isLogin.value = false;
                                    loginController.isForgot.value = true;
                                    loginController.userNameController.clear();
                                    loginController.emailController.clear();
                                    loginController.passwordController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),

                  //  forget
                  Obx(() => Visibility(
                        visible: loginController.isForgot.value,
                        child: Form(
                          key: _formKey3,
                          child: Column(
                            children: [
                              Text(
                                "Forgot Password",
                                style: appTheme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "ENTER EMAIL ADDRESS",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp emailRegExp = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (!emailRegExp.hasMatch(value)) {
                                    return 'Email is not valid';
                                  }
                                  return null;
                                },
                                controller: loginController.emailController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "name@email.com",
                                  hintText: "name@email.com",
                                ),
                              ),
                              const SizedBox(height: 40),
                              elevatedButton(
                                text: 'Get Otp',
                                onPressed: () async {
                                  if (_formKey3.currentState!.validate()) {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                      _formKey3.currentState!.save();
                                      await showProgress(context, true);
                                      loginController.forgotPasswordApi();
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You already have an account?",
                                    style: appTheme.textTheme.bodySmall,
                                  ),
                                  textButton(
                                    text: 'Login',
                                    onPressed: () {
                                      setState(() {
                                        if (!FocusScope.of(context)
                                            .hasPrimaryFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        loginController.isForgot.value = false;
                                        loginController.isLogin.value = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),

                  //  otp
                  Obx(() => Visibility(
                        visible: loginController.isOtp.value,
                        child: Form(
                          key: _formKey4,
                          child: Column(
                            children: [
                              Text(
                                "Verify Your Account",
                                style: appTheme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "ENTER OTP",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill this field';
                                  }
                                  return null;
                                },
                                controller: loginController.otpController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "Enter otp",
                                  hintText: "Enter otp",
                                ),
                              ),
                              const SizedBox(height: 40),
                              elevatedButton(
                                text: 'Verify',
                                onPressed: () async {
                                  if (_formKey4.currentState!.validate()) {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                      _formKey4.currentState!.save();
                                      await showProgress(context, true);
                                      loginController.otpApi();
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You already have an account?",
                                    style: appTheme.textTheme.bodySmall,
                                  ),
                                  textButton(
                                    text: 'Login',
                                    onPressed: () {
                                      setState(() {
                                        if (!FocusScope.of(context)
                                            .hasPrimaryFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        loginController.isOtp.value = false;
                                        loginController.isLogin.value = true;
                                        loginController.userNameController
                                            .clear();
                                        loginController.emailController.clear();
                                        loginController.passwordController
                                            .clear();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),

                  //  password
                  Obx(() => Visibility(
                        visible: loginController.isPassword.value,
                        child: Form(
                          key: _formKey5,
                          child: Column(
                            children: [
                              Text(
                                "Change Password",
                                style: appTheme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "Change Password",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp passRegExp = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (!passRegExp.hasMatch(value)) {
                                    return 'Password is not strong';
                                  }
                                  return null;
                                },
                                controller: loginController.passwordController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "Password",
                                  hintText: "Password",
                                ),
                              ),
                              const SizedBox(height: 40),
                              elevatedButton(
                                text: 'Submit',
                                onPressed: () async {
                                  if (_formKey5.currentState!.validate()) {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                      _formKey5.currentState!.save();
                                      await showProgress(context, true);
                                      loginController.changePasswordApi();
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You already have an account?",
                                    style: appTheme.textTheme.bodySmall,
                                  ),
                                  textButton(
                                    text: 'Login',
                                    onPressed: () {
                                      setState(() {
                                        if (!FocusScope.of(context)
                                            .hasPrimaryFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        loginController.isPassword.value =
                                            false;
                                        loginController.isLogin.value = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),

                  //  sign up
                  Obx(() => Visibility(
                        visible: loginController.isSignin.value,
                        child: Form(
                          key: _formKey2,
                          child: Column(
                            children: [
                              Text(
                                "Register Your Account",
                                style: appTheme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "USERNAME",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill this field';
                                  }
                                  return null;
                                },
                                controller: loginController.userNameController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "name@email.com",
                                  hintText: "name@email.com",
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "EMAIL ADDRESS",
                                style: appTheme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp emailRegExp = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (!emailRegExp.hasMatch(value)) {
                                    return 'Email is not valid';
                                  }
                                  return null;
                                },
                                controller: loginController.emailController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.email_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "name@email.com",
                                  hintText: "name@email.com",
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "PASSWORD",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: CustomTheme.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp passRegExp = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (!passRegExp.hasMatch(value)) {
                                    return 'Password is not strong';
                                  }
                                  return null;
                                },
                                obscureText: showPassword,
                                controller: loginController.passwordController,
                                cursorColor: appTheme.scaffoldBackgroundColor,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                style: appTheme.textTheme.headlineSmall,
                                decoration: CommonStyle.password_textFieldStyle(
                                  style: appTheme.textTheme.headlineSmall!,
                                  labelText: "Password",
                                  hintText: "Password",
                                  suffix: IconButton(
                                    onPressed: () => setState(
                                        () => showPassword = !showPassword),
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
                                text: 'Register',
                                onPressed: () async {
                                  if (_formKey1.currentState!.validate()) {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context).unfocus();
                                      _formKey1.currentState!.save();
                                      await showProgress(context, true);
                                      loginController.signUpApi();
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You already have an account?",
                                    style: appTheme.textTheme.bodySmall,
                                  ),
                                  textButton(
                                    text: 'Login',
                                    onPressed: () {
                                      setState(() {
                                        if (!FocusScope.of(context)
                                            .hasPrimaryFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        loginController.isSignin.value = false;
                                        loginController.isLogin.value = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
