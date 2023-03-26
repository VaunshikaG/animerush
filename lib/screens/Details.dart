import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:animerush/screens/Episode.dart';
import 'package:animerush/utils/AppConst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../podo/DetailsPodo.dart';
import '../utils/ApiService.dart';
import '../utils/CommonStyle.dart';
import '../utils/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomScreenRoute.dart';

class Details extends StatefulWidget {
  final String id;

  const Details({Key? key, required this.id})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details>{
  ScrollController scrollController = ScrollController();

  bool noData = false, showNextEp = false;
  var apiStatus,
      animeType,
      year,
      status,
      img,
      name,
      desc,
      id,
      lang,
      duration,
      ep,
      views,
      studio,
      otherName,
      nextEp;

  List<String> options = [
    "Share",
    "Watch now",
    "Add to list",
  ];
  List<IconData> optionIcon = [
    CupertinoIcons.share,
    CupertinoIcons.play_circle,
    CupertinoIcons.add_circled,
  ];

  List<String> detailTitle = [
    "Other names",
    "Language",
    "Duration",
    "Episodes",
    "Views",
    "Release Year",
    "Type",
    "Status",
    "Studios",
  ];
  List<String> details = [];

  List<String> title = [
    "One Piece",
    "Chainsaw Man",
    "Naruto Shippuden",
    "Boruto: Naruto Next Generations",
    "Kage No Jitsuryokusha Ni Naritakute!",
    "Bleach: Sennen Kessen-Hen",
    "Blue Lock",
    "Detective Conan",
    "Fumetsu No Anata E 2Nd Season",
    "High School Dxd Hero",
  ];
  List<String> titleImgs = [
    "https://cdnimg.xyz/images/anime/One-piece.jpg",
    "https://cdnimg.xyz/cover/chainsaw-man-1664388043.png",
    "https://cdnimg.xyz/images/anime/naruto_shippuden.jpg",
    "https://cdnimg.xyz/cover/boruto-naruto-next-generations.png",
    "https://cdnimg.xyz/cover/kage-no-jitsuryokusha-ni-naritakute-1664388804.png",
    "https://cdnimg.xyz/cover/bleach-sennen-kessen-hen-1664387572.png",
    "https://cdnimg.xyz/cover/blue-lock-1664387634.png",
    "https://cdnimg.xyz/cover/detective-conan.png",
    "https://cdnimg.xyz/cover/fumetsu-no-anata-e-2nd-season-1662695170.png",
    "https://cdnimg.xyz/cover/high-school-dxd-hero.png",
  ];
  List<String> titleStatus = [
    "Special  Complected  2009",
    "Special  Complected  2020",
    "Special  Complected  2015",
    "Special  Complected  2021",
    "Special  Complected  2009",
    "Special  Complected  2020",
    "Special  Complected  2015",
    "Special  Complected  2021",
    "Special  Complected  2015",
    "Special  Complected  2021",
  ];

  @override
  void initState() {
    log(runtimeType.toString());
    detailsApiCall();
    super.initState();
    apiStatus = "-";
    animeType = "-";
    year = "-";
    status = "-";
    img = "-";
    name = "-";
    desc = "-";
    id = "-";
    lang = "-";
    duration = "-";
    ep = "-";
    views = "-";
    studio = "-";
    otherName = "-";
  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.black,
          body: SafeArea(
            top: false,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  CustomAppBar(
                    title: name,
                    img: img,
                    backBtn: () {
                      Navigator.of(context).pop();
                    },
                    wishlist: () {},
                  ),
                  SliverToBoxAdapter(
                    child: (apiStatus == 200)
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //  title
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    name,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: CustomTheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "HD   •   $status   •   $animeType",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomTheme.white,
                                    ),
                                  ),
                                ),

                                //  desc
                                RichTextView(
                                  text: desc,
                                  maxLines: 4,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CustomTheme.white,
                                    fontFamily: AppConst.FONT,
                                  ),
                                  truncate: true,
                                  viewLessText: 'less',
                                  linkStyle: TextStyle(
                                    fontSize: 13,
                                    color: CustomTheme.blue,
                                    fontFamily: AppConst.FONT,
                                  ),
                                  supportedTypes: const [],
                                ),

                                //  btns
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ActionChip(
                                        elevation: 3,
                                        padding: const EdgeInsets.all(2),
                                        avatar: CircleAvatar(
                                          backgroundColor:
                                              CustomTheme.themeColor1,
                                          child: Icon(
                                            CupertinoIcons.play_circle,
                                            color: CustomTheme.black,
                                            size: 20,
                                          ),
                                        ),
                                        label: const Text('Watch Now'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              CustomScreenRoute(
                                                child: Episode(epDetails: epDetails),
                                                direction: AxisDirection.up,
                                              ));
                                        },
                                        backgroundColor:
                                            CustomTheme.themeColor1,
                                        shape: const StadiumBorder(),
                                        side: BorderSide.none,
                                      ),
                                      const SizedBox(width: 15),
                                      ActionChip(
                                        elevation: 3,
                                        padding: const EdgeInsets.all(2),
                                        avatar: CircleAvatar(
                                          backgroundColor:
                                              CustomTheme.themeColor1,
                                          child: Icon(
                                            Icons.bookmark_add_outlined,
                                            color: CustomTheme.black,
                                            size: 20,
                                          ),
                                        ),
                                        label: const Text('Watchlist'),
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     CustomScreenRoute(
                                          //       child: Episode(
                                          //         id: id,
                                          //         epDetails: epDetails,
                                          //       ),
                                          //       direction: AxisDirection.up,
                                          //     ));
                                        },
                                        backgroundColor:
                                            CustomTheme.themeColor1,
                                        shape: const StadiumBorder(),
                                        side: BorderSide.none,
                                      ),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: showNextEp,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric
                                      (vertical: 10),
                                    child: ListTile(
                                      leading: Image.asset(
                                        "assets/img/rocket.png",
                                        height: 30,
                                      ),
                                      title: Text(
                                        "Estimated the next episode will come at $nextEp",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: CustomTheme.white,
                                        ),
                                      ),
                                      minLeadingWidth: 0,
                                      trailing: IconButton(
                                        onPressed: () => setState(() => showNextEp = false),
                                        icon: Icon(
                                          CupertinoIcons.clear,
                                          size: 14,
                                          color: CustomTheme.white,
                                        ),
                                      ),
                                      tileColor: CustomTheme.blue,
                                      contentPadding: EdgeInsets.only(left: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      dense: true,
                                    ),
                                  ),
                                ),

                                // info
                                ListView.builder(
                                  itemCount: detailTitle.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return customText(
                                      text1: detailTitle[index],
                                      text2: details[index],
                                    );
                                  },
                                ),

                                // similar list
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Similar Anime",
                                    style: TextStyle(
                                      color: CustomTheme.themeColor1,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                similarList(),

                                const SizedBox(height: 20),
                              ],
                            ),
                          )
                        : Visibility(
                            visible: noData,
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/luffy1.png',
                                    width: 200,
                                  ),
                                  Image.asset(
                                    'assets/img/luffy2.png',
                                    width: 200,
                                  ),
                                  const Text(
                                    "No Data",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
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
        ),
      ),
    );
  }

  Widget similarList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 0,
        mainAxisSpacing: 125,
      ),
      // itemCount: 4,
      itemCount: title.length,
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CustomScreenRoute(
                  child: Details(id: id),
                  direction: AxisDirection.up,
                ));
          },
          child: Container(
            // height: 220,
            width: 200,
            child: Wrap(
              children: [
                Container(
                  height: 220,
                  width: 170,
                  margin: const EdgeInsets.only(left: 6),
                  child: FadeInImage.assetNetwork(
                    alignment: Alignment.center,
                    placeholder: "assets/img/icon1.png",
                    image: titleImgs[index],
                    fit: BoxFit.fill,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/img/icon1.png",
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // height: 90,
                    width: 170,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: CustomTheme.grey2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SUB",
                              style: TextStyle(
                                fontSize: 13,
                                color: CustomTheme.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "EP 1090",
                              style: TextStyle(
                                fontSize: 13,
                                color: CustomTheme.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          height: 30,
                          child: Text(
                            title[index],
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: CustomTheme.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget blurImg_detail() {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomTheme.black,
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(CustomTheme.black45, BlendMode.darken),
              image: NetworkImage(img),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar2(
                  backBtn: () {
                    Navigator.of(context).pop();
                  },
                  wishlist: () {},
                ),
                Center(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/img/icon1.png",
                    width: 150,
                    height: 220,
                    image: img,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/img/icon1.png",
                        fit: BoxFit.contain,
                      );
                    },
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Chainsaw Man",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "HD  •  Complected  •  TV Series",
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomTheme.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        disabledBackgroundColor: CustomTheme.grey1,
                        backgroundColor: CustomTheme.themeColor1,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Icon(
                        CupertinoIcons.play_fill,
                        color: CustomTheme.grey3,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        disabledBackgroundColor: CustomTheme.grey1,
                        backgroundColor: CustomTheme.themeColor1,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Icon(
                        CupertinoIcons.add,
                        color: CustomTheme.grey3,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        disabledBackgroundColor: CustomTheme.grey1,
                        backgroundColor: CustomTheme.themeColor1,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Icon(
                        CupertinoIcons.share_solid,
                        color: CustomTheme.grey3,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Text(
                    "Overview   :",
                    style: TextStyle(
                        fontSize: 15,
                        color: CustomTheme.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextView(
                        text:
                            "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: CustomTheme.white,
                          fontFamily: "Quicksand",
                        ),
                        truncate: true,
                        viewLessText: 'less',
                        linkStyle: TextStyle(
                          fontSize: 13,
                          color: CustomTheme.blue,
                          fontFamily: "Quicksand",
                        ),
                        supportedTypes: const [],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          itemCount: detailTitle.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 20,
                                  child: Text(
                                    detailTitle[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomTheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CustomTheme.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  details[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CustomTheme.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: CustomTheme.black,
          margin: const EdgeInsets.only(top: 25, bottom: 30),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 35,
              crossAxisCount: 2,
            ),
            itemCount: title.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CustomScreenRoute(
                        child: Details(id: id),
                        direction: AxisDirection.up,
                      ));
                },
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: CustomTheme.grey2,
                          // borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(titleImgs[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100,
                          // width: 160,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: CustomTheme.grey2,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                tileMode: TileMode.mirror,
                                colors: [
                                  CustomTheme.transparent,
                                  CustomTheme.transparent,
                                  CustomTheme.transparent,
                                  CustomTheme.transparent,
                                  CustomTheme.black12,
                                  // CustomTheme.black38,
                                  CustomTheme.black54,
                                  CustomTheme.black54,
                                  CustomTheme.black87,
                                  CustomTheme.black87,
                                  CustomTheme.black87,
                                  CustomTheme.black87,
                                  CustomTheme.black87,
                                ]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomTheme.blue,
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(5),
                                    ),
                                    child: Text(
                                      "SUB",
                                      style: TextStyle(
                                        color: CustomTheme.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomTheme.white,
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.all(5),
                                      ),
                                      child: Text(
                                        "EP 52",
                                        style: TextStyle(
                                          color: CustomTheme.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  title[index],
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 5),
                                child: Text(
                                  titleStatus[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget abc() {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: name,
          img: img,
          backBtn: () {
            Navigator.of(context).pop();
          },
          wishlist: () {},
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            color: CustomTheme.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Chainsaw Man",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "HD  •  Complected  •  TV Series",
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomTheme.white,
                    ),
                  ),
                ),
                RichTextView(
                  text:
                      "Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.Unfortunately, he has outlived his usefulness and is murdered by a devil in contract with the yakuza. However, in an unexpected turn of events, Pochita merges with Denji's dead body and grants him the powers of a chainsaw devil. Now able to transform parts of his body into chainsaws, a revived Denji uses his new abilities to quickly and brutally dispatch his enemies. Catching the eye of the official devil hunters who arrive at the scene, he is offered work at the Public Safety Bureau as one of them. Now with the means to face even the toughest of enemies, Denji will stop at nothing to achieve his simple teenage dreams.",
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomTheme.white,
                    fontFamily: "Quicksand",
                  ),
                  truncate: true,
                  viewLessText: 'less',
                  linkStyle: TextStyle(
                    fontSize: 13,
                    color: CustomTheme.blue,
                    fontFamily: "Quicksand",
                  ),
                  supportedTypes: const [],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: detailTitle.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 20,
                            child: Text(
                              detailTitle[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomTheme.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomTheme.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            details[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomTheme.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: similarList(),
        ),
      ],
    );
  }

  List<EpDetails> epDetails = [];
  void detailsApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    await showProgress(context, "Please wait...", true);

    APIService apiService = new APIService();
    apiService.DetailsApi().then((value) {
    // apiService.DetailsApi(animeId: widget.id).then((value) {
      try {
        if (value != null) {
          var responsebody = json.decode(value);
          DetailsPodo detailsPodo = DetailsPodo.fromJson(responsebody);
          apiStatus = responsebody["st"];
          hideProgress();
          if (apiStatus == 200) {
            setState(() {
              hideProgress();
              id = detailsPodo.data!.id ?? "-";
              name = detailsPodo.data!.name ?? "-";
              img = detailsPodo.data!.aniImage ?? detailsPodo.data!.imageHighQuality ?? "https://animerush.in/media/image/white_logo.png";
              desc = detailsPodo.data!.description ?? "-";
              year = detailsPodo.data!.airedYear ?? "-";
              otherName = detailsPodo.data!.japaneseName ?? "-";
              ep = detailsPodo.data!.episodesTillNow ?? "-";
              duration = detailsPodo.data!.duration ?? "-";
              views = detailsPodo.data!.views ?? "-";
              epDetails = detailsPodo.data!.epDetails!;

              if (detailsPodo.data!.scheduleEp != null) {
                var day = detailsPodo.data!.scheduleEp!.day ?? "";
                var date = detailsPodo.data!.scheduleEp!.date ?? "";
                var time = detailsPodo.data!.scheduleEp!.time ?? "";
                if (day.isEmpty || date.isEmpty || time.isEmpty) {
                  showNextEp = false;
                } else {
                  nextEp = "$day $date $time";
                  showNextEp = true;
                }
              } else {
                showNextEp = true;
                nextEp = "-";
              }

              for(int i = 0; i < detailsPodo.data!.studios!.length; i++) {
                studio = detailsPodo.data!.studios![i].name ?? "-";
              }


              if(detailsPodo.data!.animeWatchType == 'OV') {
                animeType = "Ovas";
              } else if(detailsPodo.data!.animeWatchType == 'ON') {
                animeType = "Onas";
              } else if(detailsPodo.data!.animeWatchType == 'M') {
                animeType = "Movies";
              } else if(detailsPodo.data!.animeWatchType == 'S') {
                animeType = "TV Series";
              } else if(detailsPodo.data!.animeWatchType == 'SP') {
                animeType = "Specials";
              } else {
                animeType = "-";
              }

              if(detailsPodo.data!.status == 'C') {
                status = "Completed";
              } else if(detailsPodo.data!.status == 'O') {
                status = "Ongoing";
              } else {
                status = "-";
              }

              if(detailsPodo.data!.type == 'S') {
                lang = "Subbed";
              } else if(detailsPodo.data!.type == 'D') {
                lang = "Dubbed";
              } else {
                lang = "-";
              }

              details.add(otherName);
              details.add(lang);
              details.add("$duration min");
              details.add(ep);
              details.add(views.toString());
              details.add(year);
              details.add(animeType);
              details.add(status);
              details.add(studio.toString());

            });
          } else {
            hideProgress();
            noData = true;
            // CustomSnackBar(context, Text(homePodo.msg!));
          }
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }

}
