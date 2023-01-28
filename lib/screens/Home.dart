import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int activeindex = 0;

  List<String> images = [
    "https://animerush.in/media/thumbnails/63fd43c52feed34e8aa90e4d0ce5cb2f_MPOypso.jpg",
    "https://animerush.in/media/thumbnails/one-piece-web.jpg",
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

  late AnimationController _controller;
  late Animation _animation;
  late Animation padding;

  @override
  void initState() {
    print(this.runtimeType);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    padding = Tween(begin: 0.0, end: -25.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease,reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  List<String> splImg = [
    "https://cdnimg.xyz/cover/fujiko-fujio-a-no-mumako.png",
    "https://cdnimg.xyz/cover/seikai-no-danshou-tanjou-dub.png",
    "https://cdnimg.xyz/images/upload/177225.jpg",
    "https://cdnimg.xyz/cover/utawarerumono-ova-picture-drama.png",
  ];
  List<String> splTitle = [
    "Fujiko Fujio A No Mumako",
    "Seikai No Danshou: Tanjou (Dub)",
    "Owari no Seraph: Nagoya Kessen-hen - Owaranai Seraph - Nagoya Kessen-hen",
    "Utawarerumono Ova Picture Drama",
  ];
  List<String> splStatus = [
    "Special  Complected  1990",
    "Special  Complected  2000",
    "Special  Complected  2016",
    "Special  Complected  2009",
  ];

  List<String> movieImg = [
    "https://cdnimg.xyz/images/Paradise Lost.jpg",
    "https://cdnimg.xyz/cover/thunderbolt-fantasy-seishi-ikken.png",
    "https://cdnimg.xyz/cover/labyrinth-of-flames-dub.png",
    "https://cdnimg.xyz/images/Kara%20no%20Kyoukai%20Mirai%20Fukuin.png",
  ];
  List<String> movieTitle = [
    "Higashi no Eden Movie II: Paradise Lost",
    "Thunderbolt Fantasy: Seishi Ikken",
    "Labyrinth Of Flames (Dub)",
    "Kara no Kyoukai: Mirai Fukuin",
  ];
  List<String> movieStatus = [
    "Movie  Complected  2010",
    "Movie  Complected  2017",
    "Movie  Complected  2000",
    "Movie  Complected  2014",
  ];

  List<String> ovaImg = [
    "https://cdnimg.xyz/images/anime/R/Refrain-Blue-OVA.jpg",
    "https://cdnimg.xyz/cover/gundress-dub.png",
    "https://cdnimg.xyz/images/anime/N/nurarihyon-no-mago.jpg",
    "https://cdnimg.xyz/images/000121.jpg",
  ];
  List<String> ovaTitle = [
    "Refrain Blue Ova",
    "Gundress (Dub)",
    "Nurarihyon No Mago Ova",
    "Queen’S Blade Vanquished Queens Ova",
  ];
  List<String> ovaStatus = [
    "Ovas  Complected  2009",
    "Ovas  Complected  1999",
    "Ovas  Complected  2012",
    "Ovas  Complected  2013",
  ];

  List<String> onaImg = [
    "https://cdnimg.xyz/cover/miru-tights.png",
    "https://cdnimg.xyz/cover/revisions.png",
    "https://cdnimg.xyz/cover/moshi-juexing-zhi-suyuan.png",
    "https://cdnimg.xyz/cover/sekai-no-owari-ni-shiba-inu-to.png",
  ];
  List<String> onaTitle = [
    "Miru Tights",
    "Revisions",
    "Moshi Juexing Zhi Suyuan",
    "Sekai No Owari Ni Shiba Inu To",
  ];
  List<String> onaStatus = [
    "Onas  Complected  2019",
    "Onas  Complected  2019",
    "Onas  Complected  2000",
    "Onas  Ongoing  2022",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.092,
                              margin: const EdgeInsets.only(right: 5),
                              child: CarouselSlider.builder(
                                itemCount: images.length,
                                itemBuilder:
                                    (BuildContext context, int index, _) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 0)
                                          ? CustomTheme.blur
                                          : Colors.white.withOpacity(0.0),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          images[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white24.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          tileMode: TileMode.mirror,
                                          colors: (index % 2 == 0)
                                              ? [
                                                  Colors.white38,
                                                  Colors.white10,
                                                  CustomTheme.transparent,
                                                  CustomTheme.transparent,
                                                ]
                                              : [
                                                  Colors.black87,
                                                  Colors.black54,
                                                  Colors.black38,
                                                  Colors.black12,
                                                  Colors.black12,
                                                ],
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "#${index + 1} Spotlight",
                                              style: TextStyle(
                                                color: (index % 2 == 0)
                                                    ? CustomTheme.themeColor2
                                                    : CustomTheme.white,
                                                // color: CustomTheme.themeColor2,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(bottom: 20),
                                            child: Text(
                                              title[index],
                                              style: TextStyle(
                                                color: (index % 2 == 0)
                                                    ? CustomTheme.themeColor2
                                                    : CustomTheme.white,
                                                // color: CustomTheme.themeColor2,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                            child: CupertinoButton(
                                              onPressed: () {},
                                              color: CustomTheme.blur3,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                              disabledColor: CustomTheme.white,
                                              pressedOpacity: 0.6,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: SizedBox(
                                                width: 55,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .info_circle_fill,
                                                      size: 14,
                                                      color: CustomTheme.white,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      "Details",
                                                      style: TextStyle(
                                                        color: CustomTheme.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            height: 30,
                                            child: CupertinoButton(
                                              onPressed: () {},
                                              color: CustomTheme.themeColor1,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                              disabledColor: CustomTheme.white,
                                              pressedOpacity: 0.6,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: SizedBox(
                                                width: 90,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .play_circle_fill,
                                                      size: 15,
                                                      color:
                                                          CustomTheme.themeColor2,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      "Watch Now",
                                                      style: TextStyle(
                                                        color: CustomTheme
                                                            .themeColor2,
                                                        fontSize: 13,
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
                                  );
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, _) {
                                    setState(() => activeindex = index);
                                  },
                                  height: 200,
                                  autoPlay: true,
                                  pageSnapping: true,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  aspectRatio: 12 / 12,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 0.9,
                                ),
                              ),
                            ),
                            AnimatedSmoothIndicator(
                              curve: Curves.easeInOut,
                              activeIndex: activeindex,
                              axisDirection: Axis.vertical,
                              count: images.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 15,
                                activeDotColor: CustomTheme.themeColor1,
                                dotColor: CustomTheme.blur2,
                              ),
                            ),
                          ],
                        ),

                        //  trending
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Trending",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                            itemCount: title.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 190,
                                      width: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      margin: EdgeInsets.zero,
                                      color: CustomTheme.blur,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: RotatedBox(
                                                    quarterTurns: -1,
                                                    child: SizedBox(
                                                      width: 120,
                                                      child: Text(
                                                        title[index],
                                                        softWrap: true,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: CustomTheme.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              color: CustomTheme.themeColor1,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 190,
                                      width: 130,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                          titleImgs[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        //  types
                        Container(
                          color: CustomTheme.blur2,
                          margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Special",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemCount: splImg.length,
                            itemBuilder: (BuildContext listCtx, int index) {
                              return ListTile(
                                leading: FadeInImage.assetNetwork(
                                  placeholder: "assets/img/icon1.png",
                                  image: splImg[index],
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/img/icon1.png",
                                      fit: BoxFit.contain,
                                    );
                                  },
                                  fit: BoxFit.contain,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    splTitle[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    splStatus[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                dense: true,
                                tileColor: (index % 2 == 0) ? CustomTheme.blur : CustomTheme.blur2,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              );
                            }),
                        ),
                        Container(
                          color: CustomTheme.blur2,
                          margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Movies",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemCount: movieImg.length,
                            itemBuilder: (BuildContext listCtx, int index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 50,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/img/icon1.png",
                                    image: movieImg[index],
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
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    movieTitle[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    movieStatus[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                dense: true,
                                tileColor: (index % 2 == 0) ? CustomTheme.blur : CustomTheme.blur2,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: CustomTheme.blur2,
                          margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ONA",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemCount: onaImg.length,
                            itemBuilder: (BuildContext listCtx, int index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 50,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/img/icon1.png",
                                    image: onaImg[index],
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
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    onaTitle[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    onaStatus[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                dense: true,
                                tileColor: (index % 2 == 0) ? CustomTheme.blur : CustomTheme.blur2,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: CustomTheme.blur2,
                          margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OVA",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemCount: ovaImg.length,
                            itemBuilder: (BuildContext listCtx, int index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 50,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/img/icon1.png",
                                    image: ovaImg[index],
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
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    ovaTitle[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    ovaStatus[index],
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                dense: true,
                                tileColor: (index % 2 == 0) ? CustomTheme.blur : CustomTheme.blur2,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }

  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(images[pagePosition]))),
    );
  }

  imageAnimation(PageController animation, images, pagePosition) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        print(pagePosition);

        return SizedBox(
          width: 200,
          height: 200,
          child: widget,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Image.network(images[pagePosition]),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
