import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/LoginController.dart';
import '../controllers/WatchListController.dart';
import '../utils/AppConst.dart';
import '../utils/CommonStyle.dart';
import '../utils/theme.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/Loader.dart';
import 'Details.dart';
import 'Splash.dart';

WatchListController wishListController = Get.put(WatchListController());
LoginController loginController = Get.put(LoginController());

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  bool showPassword = true, showLog = false;
  TabController? _controller;

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 1), ()
    {
      loginController.isLoggedIn.value =
          prefs.getBool(AppConst.loginStatus) ?? false;
      // loginController.email = prefs.getString(AppConst.email) ?? '-';
      // loginController.userName = prefs.getString(AppConst.userName) ?? '-';
      loginController.dateJoined = prefs.getString(AppConst.dateJoined) ?? DateTime.now().toString();
      DateTime? dateTime = DateTime.parse(loginController.dateJoined);
      loginController.dateJoined = DateFormat('dd MMM yyyy').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // child: tabSection(),
                child: Obx(() => (loginController.isLoggedIn.value == false) ? signup() : tabSection()),
              ),
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
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      style: appTheme.textTheme.headlineSmall,
                      decoration: CommonStyle.password_textFieldStyle(
                        style: appTheme.textTheme.headlineSmall!,
                        labelText: "Password",
                        hintText: "Password",
                        suffix: IconButton(
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
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
                        RegExp emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                        RegExp emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      style: appTheme.textTheme.headlineSmall,
                      decoration: CommonStyle.password_textFieldStyle(
                        style: appTheme.textTheme.headlineSmall!,
                        labelText: "Password",
                        hintText: "Password",
                        suffix: IconButton(
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
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

  Widget tabSection() {
    return DefaultTabController(
      length: 2,
      child: Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            child: TabBar(
              controller: _controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              tabs: [
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(
                      child: Text("Profile"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(
                      child: Text("Continue Watching"),
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
                profile(),
                const ContinueWatch(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profile() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: appTheme.scaffoldBackgroundColor,
                child: Image.asset(
                  "assets/img/profile.png",
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            customTile(text1: 'EMAIL ADDRESS', text2: loginController.email),
            customTile(text1: 'EMAIL USERNAME', text2: loginController.userName),
            customTile(text1: 'DATE JOINED', text2: loginController.dateJoined),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ExpansionTile(
                leading: Icon(
                  Icons.key,
                  color: appTheme.iconTheme.color,
                ),
                title: Text(
                  'Change password',
                  style: appTheme.textTheme.titleSmall,
                ),
                children: [
                  Form(
                    key: _formKey6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "CURRENT PASSWORD",
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
                          controller: loginController.passwordController,
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
                          "NEW PASSWORD",
                          style: appTheme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
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
                          controller: loginController.newPasswordController,
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
                              onPressed: () =>
                                  setState(() => showPassword = !showPassword),
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
                          text: 'Save',
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              if (!FocusScope.of(context).hasPrimaryFocus) {
                                FocusScope.of(context).unfocus();
                              }
                              _formKey1.currentState!.save();
                              loginController.profilePasswordApi();
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 10),
              constraints: const BoxConstraints(maxWidth: 120),
              child: ListTile(
                onTap: () async {
                  // loginController.isLoggedIn.value = true;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Get.deleteAll();
                  Get.offAll(() => const Splash());
                },
                leading: Icon(
                  Icons.logout,
                  size: 19,
                  color: appTheme.iconTheme.color,
                ),
                title: Text(
                  'Logout',
                  style: appTheme.textTheme.titleSmall,
                ),
                tileColor: appTheme.colorScheme.surface,
                visualDensity: const VisualDensity(vertical: -4),
                minLeadingWidth: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget continueWatch() {
    final appTheme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 160,
      ),
      itemCount: wishListController.continueList!.length,
      itemBuilder: (BuildContext ctx, index) {
        final continueList = wishListController.continueList![index];
        final lang;

        if(continueList.anime!.type == 'S') {
          lang = "SUB";
        } else if(continueList.anime!.type == 'D') {
          lang = "DUB";
        } else {
          lang = "-";
        }

        return GestureDetector(
          onTap: () {
            // Get.offAll(() => Details(id: continueList.id.toString()));
          },
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(color: CustomTheme.grey300),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage.assetNetwork(
                      alignment: Alignment.center,
                      placeholder: "assets/img/blank.png",
                      image: continueList.anime!.aniImage ?? continueList.anime!.imageHighQuality!,
                      fit: BoxFit.fill,
                      height: 150,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/img/blank.png",
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (lang == "SUB")
                            ? appTheme.indicatorColor
                            : appTheme.colorScheme.error,
                      ),
                      child: Text(
                        lang,
                        style: appTheme.textTheme.labelSmall,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Watching Ep  :   ${continueList.episode}",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appTheme.textTheme.titleMedium,
                      ),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

class ContinueWatch extends StatefulWidget {
  const ContinueWatch({super.key});

  @override
  State<ContinueWatch> createState() => _ContinueWatchState();
}

class _ContinueWatchState extends State<ContinueWatch> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, true);
    Future.delayed(Duration(seconds: 1), () {
    wishListController.continueApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 130,
      ),
      itemCount: wishListController.continueList!.length,
      itemBuilder: (BuildContext ctx, index) {
        final continueList = wishListController.continueList![index];
        final lang;

        if(continueList.anime!.type == 'S') {
          lang = "SUB";
        } else if(continueList.anime!.type == 'D') {
          lang = "DUB";
        } else {
          lang = "-";
        }

        return GestureDetector(
          onTap: () {
            Get.offAll(() => Details(id: continueList.id.toString()));
          },
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            // decoration: BoxDecoration(color: CustomTheme.grey300),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage.assetNetwork(
                      alignment: Alignment.center,
                      placeholder: "assets/img/blank.png",
                      image: continueList.anime!.aniImage ?? continueList.anime!.imageHighQuality!,
                      fit: BoxFit.fill,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/img/blank.png",
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (lang == "SUB")
                            ? appTheme.indicatorColor
                            : appTheme.colorScheme.error,
                      ),
                      child: Text(
                        lang,
                        style: appTheme.textTheme.labelSmall,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Watching Ep  :   ${continueList.episode}",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appTheme.textTheme.titleSmall,
                      ),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      visualDensity: const VisualDensity(vertical: -4),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

