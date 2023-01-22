import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomScreenRoute.dart';
import 'Home.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: SizedBox(
            width: 50,
            child: Drawer(
              shape: const Border.symmetric(vertical: BorderSide()),
              backgroundColor: Colors.black54,
              // backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  Text(
                    "Types",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Types",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Types",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
