import 'package:animate_do/animate_do.dart';
import 'package:animerush/theme.dart';
import 'package:flutter/cupertino.dart';
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
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Splash(),
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
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/img/c.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(CustomTheme.themeColor1, BlendMode.darken),
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
                child: const Text(
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
                  child: const Text(
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
                  label: const Text(
                    'Continue',
                    style: TextStyle(color: CustomTheme.themeColor1),
                  ),
                  backgroundColor: CustomTheme.themeColor2,
                  icon: const Icon(
                    CupertinoIcons.arrowtriangle_right_fill,
                    size: 24,
                    color: CustomTheme.themeColor1,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, CustomScreenRoute(child: const MyHomePage(title: 'Anime Rush'), direction: AxisDirection.up));
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


class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
