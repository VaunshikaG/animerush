import 'dart:developer';
import 'dart:ui';
import 'package:animerush/screens/Episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_view/rich_text_view.dart';
import '../CommonStyle.dart';
import '../theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomScreenRoute.dart';

class Details extends StatefulWidget {
  final String title;
  final String img;

  const Details({Key? key, required this.title, required this.img})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController _tabController;

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
    "Episodes",
    "Views",
    "Release Year",
    "Type",
    "Status",
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
    _tabController = TabController(vsync:this, length: 2);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  var top = 0.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    setState(() {
      opacity2 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.themeColor2,
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
                    title: widget.title,
                    img: widget.img,
                    backBtn: () {
                      Navigator.of(context).pop();
                    },
                    wishlist: () {},
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ActionChip(
                                  elevation: 3,
                                  padding: const EdgeInsets.all(2),
                                  avatar: CircleAvatar(
                                    backgroundColor: CustomTheme.themeColor1,
                                    child: Icon(
                                      CupertinoIcons.play_circle,
                                      color: CustomTheme.themeColor2,
                                      size: 20,
                                    ),
                                  ),
                                  label: const Text('Watch Now'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CustomScreenRoute(
                                          child: Episode(title: widget.title),
                                          direction: AxisDirection
                                              .up,
                                        ));
                                  },
                                  backgroundColor: CustomTheme.themeColor1,
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                ),
                                const SizedBox(width: 15),
                                ActionChip(
                                  elevation: 3,
                                  padding: const EdgeInsets.all(2),
                                  avatar: CircleAvatar(
                                    backgroundColor: CustomTheme.themeColor1,
                                    child: Icon(
                                      Icons.bookmark_add_outlined,
                                      color: CustomTheme.themeColor2,
                                      size: 20,
                                    ),
                                  ),
                                  label: const Text('Watchlist'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CustomScreenRoute(
                                          child: Episode(title: widget.title),
                                          direction: AxisDirection
                                              .up,
                                        ));
                                  },
                                  backgroundColor: CustomTheme.themeColor1,
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: detailTitle.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                            itemBuilder: (BuildContext context, int index) {
                              return customText(
                                text1: detailTitle[index],
                                text2: details[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: similarList(),
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
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
        Container(
          color: CustomTheme.themeColor2,
          margin: const EdgeInsets.only(bottom: 30),
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
                        child: Details(
                          title: title[index],
                          img: titleImgs[index],
                        ),
                        direction: AxisDirection.up,
                      ));
                },
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
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black12,
                                // Colors.black38,
                                Colors.black54,
                                Colors.black54,
                                Colors.black87,
                                Colors.black87,
                                Colors.black87,
                                Colors.black87,
                                Colors.black87,
                              ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  padding: const EdgeInsets.only(right: 8),
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
                                        color: CustomTheme.themeColor2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
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
                              padding: const EdgeInsets.only(left: 3, top: 5),
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget blurImg_detail() {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomTheme.themeColor2,
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black45, BlendMode.darken),
              image: NetworkImage(widget.img),
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
                    image: widget.img,
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
          color: CustomTheme.themeColor2,
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
                        child: Details(
                          title: title[index],
                          img: titleImgs[index],
                        ),
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
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                tileMode: TileMode.mirror,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black12,
                                  // Colors.black38,
                                  Colors.black54,
                                  Colors.black54,
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black87,
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
                                          color: CustomTheme.themeColor2,
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
          title: widget.title,
          img: widget.img,
          backBtn: () {
            Navigator.of(context).pop();
          },
          wishlist: () {},
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            color: CustomTheme.themeColor2,
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

}
