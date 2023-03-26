import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/AppConst.dart';
import '../utils/CommonStyle.dart';
import '../utils/theme.dart';
import '../widgets/CustomCard.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool showPassword = true;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.transparent,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                          controller: userNameController,
                          cursorColor: CustomTheme.black,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(AppConst.emailRegex),
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                          decoration: email_textFieldStyle(
                            labelText: "Email or Username",
                            hintText: "name@email.com",
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: showPassword,
                          controller: passwordController,
                          cursorColor: CustomTheme.black,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(AppConst.passwordRegex),
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                          decoration: password_textFieldStyle(
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
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // perform login with email and password
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
