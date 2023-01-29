import 'package:animate_do/animate_do.dart';
import 'package:animerush/screens/BottomBar.dart';
import 'package:animerush/screens/HomeDrawer.dart';
import 'package:animerush/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/CustomScreenRoute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Rush',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const BottomBar(currentIndex: 0),
      // home: const Splash(),
    );
  }
}


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Duration duration = const Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: const AssetImage('assets/img/c.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(CustomTheme.themeColor1, BlendMode.softLight),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.only(top: 150, bottom: 45),
                  width: size.width / 1.5,
                  height: size.height / 8,
                  child: Image.asset('assets/img/white_logo.png'),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 1000),
                child: Text(
                  "Welcome !",
                  style: TextStyle(
                      color: CustomTheme.themeColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 1500),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 200),
                  child: Text(
                    "AnimeRush.in - The best platform to watch anime online for Free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        color: CustomTheme.themeColor1,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 2000),
                child: FloatingActionButton.extended(
                  extendedPadding: const EdgeInsets.symmetric(horizontal: 30),
                  label: Text(
                    'Continue',
                    style: TextStyle(color: CustomTheme.themeColor1),
                  ),
                  backgroundColor: CustomTheme.themeColor2,
                  icon: Icon(
                    CupertinoIcons.arrowtriangle_right_fill,
                    size: 24,
                    color: CustomTheme.themeColor1,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, CustomScreenRoute(child: const BottomBar(currentIndex: 0), direction:
                    AxisDirection.up));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
