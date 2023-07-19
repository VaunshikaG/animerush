import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/LoginController.dart';
import '../utils/AppConst.dart';
import '../utils/CommonStyle.dart';
import '../utils/theme.dart';
import '../widgets/CustomButtons.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  LoginController loginController = Get.put(LoginController());

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  bool showPassword = true, showLog = false;
  TabController? _controller;

  @override
  void initState() {
    log(runtimeType.toString());
    // loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    // isLoggedIn = prefs.getBool(AppConst.LOGINSTATUS)!;
    loginController.isLoggedIn.value = false;
    loginController.isLogin.value = true;
    loginController.isSignin.value = false;
    loginController.isForgot.value = false;
    loginController.isOtp.value = false;
    loginController.isPassword.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: loginController.isLoggedIn.isFalse
                  ? signup()
                  : _tabSection(),
            ),
          ),
        ),
      ),
    );
  }


  Widget signup() {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  login
        Obx(() => Visibility(
          visible: loginController.isLogin.value,
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                Text(
                  "PASSWORD",
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp passRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
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
                    FilteringTextInputFormatter.singleLineFormatter,
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
                  onPressed: () {
                    if (_formKey1.currentState!.validate()) {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      _formKey1.currentState!.save();
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
                          if (!FocusScope.of(context).hasPrimaryFocus) {
                            FocusScope.of(context).unfocus();
                          }
                          loginController.isLogin.value = false;
                          loginController.isSignin.value = true;
                        });
                      },
                    ),
                  ],
                ),
                textButton(
                  text: 'Forgot Password',
                  onPressed: () {
                    setState(() {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      loginController.isLogin.value = false;
                      loginController.isForgot.value = true;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                    FilteringTextInputFormatter.singleLineFormatter,
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
                  onPressed: () {
                    if (_formKey3.currentState!.validate()) {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                        _formKey3.currentState!.save();
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
                          if (!FocusScope.of(context).hasPrimaryFocus) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    FilteringTextInputFormatter.allow(AppConst.emailRegex),
                    FilteringTextInputFormatter.singleLineFormatter,
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
                  onPressed: () {
                    if (_formKey4.currentState!.validate()) {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                        _formKey4.currentState!.save();
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
                          if (!FocusScope.of(context).hasPrimaryFocus) {
                            FocusScope.of(context).unfocus();
                          }
                          loginController.isOtp.value = false;
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

        //  password
        Obx(() => Visibility(
          visible: loginController.isPassword.value,
          child: Form(
            key: _formKey5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp passRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
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
                    FilteringTextInputFormatter.singleLineFormatter,
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
                  onPressed: () {
                    if (_formKey5.currentState!.validate()) {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                        _formKey5.currentState!.save();
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
                          if (!FocusScope.of(context).hasPrimaryFocus) {
                            FocusScope.of(context).unfocus();
                          }
                          loginController.isPassword.value = false;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                Text(
                  "EMAIL ADDRESS",
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                    FilteringTextInputFormatter.allow(AppConst.emailRegex),
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
                Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomTheme.grey,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp passRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
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
                    FilteringTextInputFormatter.singleLineFormatter,
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
                  onPressed: () {
                    if (_formKey1.currentState!.validate()) {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                        _formKey1.currentState!.save();
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
                          if (!FocusScope.of(context).hasPrimaryFocus) {
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
    );
  }

  Widget _tabSection() {
    final appTheme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            child: TabBar(
              controller: _controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              labelColor: appTheme.scaffoldBackgroundColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appTheme.primaryColor,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              tabs: [
                Tab(
                  height: 35,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appTheme.primaryColor, width: 1),
                    ),
                    child: const Center(
                      child: Text("Profile"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appTheme.primaryColor, width: 1),
                    ),
                    child: const Center(
                      child: Text("Continue Watching"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appTheme.primaryColor, width: 1),
                    ),
                    child: const Center(
                      child: Text("WatchList"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.82,
            child: TabBarView(
              controller: _controller,
              children: [
                Profile(), ContinueWatch(), WatchList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Profile() {
    return Column();
  }
  Widget ContinueWatch() {
    return Column();
  }
  Widget WatchList() {
    return Column();
  }

}
