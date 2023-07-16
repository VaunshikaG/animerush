import 'dart:developer';

import 'package:animerush/utils/AppConst.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../model/EpDetailPodo.dart';
import '../model/VdResolutionModel.dart';
import '../utils/theme.dart';

class Player extends StatefulWidget {
  final String url, placeHolder, title;
  final List<DownloadEpisodeLink> dwldList;
  const Player({Key? key, required this.url, required this.placeHolder, required this.title, required this.dwldList}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();
  bool flag = false;

  @override
  void initState() {
    log(runtimeType.toString());
    super.initState();

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      videoFormat: BetterPlayerVideoFormat.hls,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
      },
      resolutions: AppConst.exampleResolutionsUrls,
      notificationConfiguration: const BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: "Chainsaw Man",
        author: "animerush.in",
        imageUrl: AppConst.placeHolderImg,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        looping: false,
        autoPlay: false,
        placeholderOnTop: true,
        placeholder: Image.network(
          AppConst.placeHolderImg,
          fit: BoxFit.contain,
        ),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          controlBarColor: CustomTheme.transparent,
          iconsColor: CustomTheme.white,
          progressBarBufferedColor: CustomTheme.white,
          progressBarPlayedColor: CustomTheme.themeColor1,
          loadingColor: CustomTheme.themeColor1,
          progressBarHandleColor: CustomTheme.themeColor1,
          playIcon: Icons.play_arrow,
          muteIcon: Icons.volume_up_sharp,
          unMuteIcon: Icons.volume_off_sharp,
          pipMenuIcon: Icons.picture_in_picture,
          enablePip: true,
          enableRetry: true,
          overflowMenuCustomItems: [
            BetterPlayerOverflowMenuItem(
              Icons.picture_in_picture,
              "Picture in Picture",
              () => _betterPlayerController.enablePictureInPicture(_betterPlayerKey),
            ),
          ],
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
    _betterPlayerController.setOverriddenFit(BoxFit.contain);
    _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
    _betterPlayerController.setControlsAlwaysVisible(true);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
        key: _betterPlayerKey,
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }
}
