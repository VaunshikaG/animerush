import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'HomeDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();

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

  @override
  void initState() {
    print(this.runtimeType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: CustomTheme.blur,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    images[0],
                                  ),
                                  fit: BoxFit.cover)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.white38,
                                  Colors.white10,
                                  CustomTheme.transparent,
                                  CustomTheme.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "#1 Spotlight",
                                    style: TextStyle(
                                      color: CustomTheme.themeColor2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "One Piece",
                                    style: TextStyle(
                                      color: CustomTheme.themeColor2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    // "One Piece is a story about Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat...",
                                    'One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult.One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult. But along his ways, he meet himself many members to help. Together, they sail the Seven Seas of adventure in search of the elusive treasure "One Piece."',
                                    softWrap: true,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: CustomTheme.themeColor2,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: CupertinoButton(
                                          onPressed: () {},
                                          color: CustomTheme.themeColor1,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: SizedBox(
                                            width: 90,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.play_circle_fill,
                                                  size: 15,
                                                  color: CustomTheme.themeColor2,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Watch Now",
                                                  style: TextStyle(
                                                    color: CustomTheme.themeColor2,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        height: 30,
                                        child: CupertinoButton(
                                          onPressed: () {},
                                          color: CustomTheme.blur2,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: SizedBox(
                                            width: 55,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.info_circle_fill,
                                                  size: 15,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                              // color: CustomTheme.blur,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    images[1],
                                  ),
                                  fit: BoxFit.cover)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black87,
                                  Colors.black54,
                                  Colors.black38,
                                  Colors.black12,
                                  Colors.black12,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "#1 Spotlight",
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "One Piece",
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    // "One Piece is a story about Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat...",
                                    'One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult.One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult. But along his ways, he meet himself many members to help. Together, they sail the Seven Seas of adventure in search of the elusive treasure "One Piece."',
                                    softWrap: true,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: CupertinoButton(
                                          onPressed: () {},
                                          color: CustomTheme.themeColor1,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: SizedBox(
                                            width: 90,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.play_circle_fill,
                                                  size: 15,
                                                  color: CustomTheme.themeColor2,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Watch Now",
                                                  style: TextStyle(
                                                    color: CustomTheme.themeColor2,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        height: 30,
                                        child: CupertinoButton(
                                          onPressed: () {},
                                          color: CustomTheme.blur2,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: SizedBox(
                                            width: 55,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.info_circle_fill,
                                                  size: 15,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        pageSnapping: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        aspectRatio: 12 / 12,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.9,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          color: CustomTheme.themeColor1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                          itemCount: title.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(vertical: 0),
                              height: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 190,
                                    width: 40,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: CustomTheme.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
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
                          }),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: CustomTheme.blur,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                images[0],
                              ),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white38,
                              Colors.white10,
                              CustomTheme.transparent,
                              CustomTheme.transparent,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "#1 Spotlight",
                                style: TextStyle(
                                  color: CustomTheme.themeColor2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "One Piece",
                                style: TextStyle(
                                  color: CustomTheme.themeColor2,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                // "One Piece is a story about Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat...",
                                'One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult.One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult. But along his ways, he meet himself many members to help. Together, they sail the Seven Seas of adventure in search of the elusive treasure "One Piece."',
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: CustomTheme.themeColor2,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: CupertinoButton(
                                      onPressed: () {},
                                      color: CustomTheme.themeColor1,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      disabledColor: CustomTheme.white,
                                      pressedOpacity: 0.6,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: SizedBox(
                                        width: 90,
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.play_circle_fill,
                                              size: 15,
                                              color: CustomTheme.themeColor2,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Watch Now",
                                              style: TextStyle(
                                                color: CustomTheme.themeColor2,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 30,
                                    child: CupertinoButton(
                                      onPressed: () {},
                                      color: CustomTheme.blur2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      disabledColor: CustomTheme.white,
                                      pressedOpacity: 0.6,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: SizedBox(
                                        width: 55,
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.info_circle_fill,
                                              size: 15,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.0),
                          // color: CustomTheme.blur,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                images[1],
                              ),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black87,
                              Colors.black54,
                              Colors.black38,
                              Colors.black12,
                              Colors.black12,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "#1 Spotlight",
                                style: TextStyle(
                                  color: CustomTheme.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "One Piece",
                                style: TextStyle(
                                  color: CustomTheme.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                // "One Piece is a story about Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat...",
                                'One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult.One Piece is a story about  Monkey D. Luffy, who wants to become a sea-robber. In a world mystical, there have a mystical fruit whom eat will have a special power but also have greatest weakness. Monkey ate Gum-Gum Fruit which gave him a strange power but he can NEVER swim. And this weakness made his dream become a sea – robber to find ultimate treasure is difficult. But along his ways, he meet himself many members to help. Together, they sail the Seven Seas of adventure in search of the elusive treasure "One Piece."',
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: CustomTheme.white,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: CupertinoButton(
                                      onPressed: () {},
                                      color: CustomTheme.themeColor1,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      disabledColor: CustomTheme.white,
                                      pressedOpacity: 0.6,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: SizedBox(
                                        width: 90,
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.play_circle_fill,
                                              size: 15,
                                              color: CustomTheme.themeColor2,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Watch Now",
                                              style: TextStyle(
                                                color: CustomTheme.themeColor2,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 30,
                                    child: CupertinoButton(
                                      onPressed: () {},
                                      color: CustomTheme.blur2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      disabledColor: CustomTheme.white,
                                      pressedOpacity: 0.6,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: SizedBox(
                                        width: 55,
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.info_circle_fill,
                                              size: 15,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
