import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/CustomAppBar.dart';

class Details extends StatefulWidget {
  final String title;
  final String img;

  const Details({Key? key, required this.title, required this.img})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  ScrollController scrollController = ScrollController();

  List<String> options = [
    "Share",
    "Watch now",
    "Add to\nlist",
  ];
  List<IconData> optionIcon = [
    CupertinoIcons.share,
    CupertinoIcons.play_circle,
    CupertinoIcons.add_circled,
  ];

  List<String> detailTitle = [
    "Other names  :",
    "Language  :",
    "Episodes  :",
    "Views  :",
    "Release Year  :",
    "Type  :",
    "Status  :",
  ];
  List<String> details = [
    "チェンソーマン",
    "Subbed",
    "12",
    "91",
    "2022",
    "TV Series",
    "Complected",
  ];

  @override
  void initState() {
    print(this.runtimeType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.themeColor2,
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: detailTile(),
                  ),
                  /*Positioned(
                    bottom: 100,
                    right: 0,
                    // alignment: Alignment.bottomCenter,
                    child: Container(
                      // alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: CustomTheme.transparent,
                          // color: CustomTheme.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chainsaw Man",
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "HD   Complected    TV Series",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomTheme.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 260,
                            child: Text(
                              "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                              maxLines: 7,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: CustomTheme.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: AlertDialog(
                                      backgroundColor: CustomTheme.grey1,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      title: Text(
                                        "Chainsaw Man",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomTheme.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: CustomTheme.white,
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        CupertinoButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'close');
                                          },
                                          color: CustomTheme.grey1,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: CustomTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              visualDensity: const VisualDensity(vertical: -4),
                            ),
                            child: Text(
                              "More",
                              style: TextStyle(
                                color: CustomTheme.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailTile() {
    return Stack(
      children: [
        Container(
          height: 550,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white24, BlendMode.lighten),
              image: NetworkImage(
                // "assets/img/background2.png",
                widget.img,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0)),
            ),
          ),
        ),
        const CustomAppBar2(),
        Positioned(
          right: 10,
          bottom: 70,
          child: Container(
            width: 70,
            padding: const EdgeInsets.only(bottom: 10, top: 15),
            decoration: BoxDecoration(
              color: CustomTheme.grey1,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: CustomTheme.grey3, //New
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: CustomTheme.grey1,
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 5),
                  disabledColor: CustomTheme.white,
                  pressedOpacity: 0.6,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        optionIcon[index],
                        size: 20,
                        color: CustomTheme.themeColor1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        options[index],
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: CustomTheme.white,
                          fontSize: 13,
                          fontFamily: "Quicksand",
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/img/icon1.png",
              image: widget.img,
              height: 150,
              imageErrorBuilder:
                  (context, error, stackTrace) {
                return Image.asset(
                  "assets/img/icon1.png",
                  fit: BoxFit.contain,
                );
              },
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: CustomTheme.grey3.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chainsaw Man",
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomTheme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "HD   Complected    TV Series",
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomTheme.white,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                    maxLines: 8,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: CustomTheme.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: AlertDialog(
                            backgroundColor: CustomTheme.grey1,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            title: Text(
                              "Chainsaw Man",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustomTheme.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: CustomTheme.white,
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context, 'close');
                                },
                                color: CustomTheme.grey1,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                disabledColor: CustomTheme.white,
                                pressedOpacity: 0.6,
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(5)),
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CustomTheme.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    visualDensity: const VisualDensity(vertical: -4),
                  ),
                  child: Text(
                    "More",
                    style: TextStyle(
                      color: CustomTheme.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
