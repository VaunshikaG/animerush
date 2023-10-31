1.  banner
class _WatchListState extends State<WatchList> with IronSourceBannerListener {

    // to destory banner
    //  IronSource.destroyBanner();
    //  log('destroyBanner');
  bool isBannerLoaded = false;
  bool bannerCapped = false;
  final size = IronSourceBannerSize.BANNER;

  @override
  void initState() {
    initAds();
    super.initState();
  }

  Future<void> initAds() async {
    IronSource.setBannerListener(this);
    if (!bannerCapped) {
      bannerCapped = await IronSource.isBannerPlacementCapped('DefaultBanner');
      log('Banner DefaultBanner capped: $bannerCapped');
      // size.isAdaptive = true; // Adaptive Banner
      IronSource.loadBanner(
          size: size,
          position: IronSourceBannerPosition.Bottom,
          // verticalOffset: 40,
          verticalOffset: -(MediaQuery.of(context).size.height * 0.242).toInt(),
          placementName: 'DefaultBanner');
      log('banner displayed');
      IronSource.displayBanner();
    }
  }

  /// Banner listener ==================================================================================
  @override
  void onBannerAdClicked() {
    log("onBannerAdClicked");
  }

  @override
  void onBannerAdLoadFailed(IronSourceError error) {
    log("onBannerAdLoadFailed Error:$error");
    if (mounted) {
      setState(() {
        isBannerLoaded = false;
      });
    }
  }

  @override
  void onBannerAdLoaded() {
    log("onBannerAdLoaded");
    if (mounted) {
      setState(() {
        isBannerLoaded = true;
      });
    }
  }

  @override
  void onBannerAdScreenDismissed() {
    log("onBannerAdScreenDismissed");
  }

  @override
  void onBannerAdScreenPresented() {
    log("onBannerAdScreenPresented");
  }

  @override
  void onBannerAdLeftApplication() {
    log("onBannerAdLeftApplication");
  }
}

2.  interstial
class _WatchListState extends State<WatchList> with IronSourceBannerListener, IronSourceInterstitialListener {

  bool isInterstitialAvailable = false;
  bool interstitialCapped = false;
  bool interstitialClosed = false;

  bool isBannerLoaded = false;
  bool bannerCapped = false;
  final size = IronSourceBannerSize.BANNER;


// both at same time

  Future<void> _handleButtonClick(void Function() onPressed) async {
    final prefs = await SharedPreferences.getInstance();
    String formatted = DateFormat('HH:mm').format(DateTime.now());
    DateTime now = DateTime.now();
    DateTime? lastClicked = prefs.containsKey(AppConst.adTimeStamp2)
        ? DateTime.parse(prefs.getString(AppConst.adTimeStamp2)!)
        : null;

    IronSource.destroyBanner();
    log('destroyBanner');

    if (lastClicked == null || now.difference(lastClicked).inMinutes >= 10) {
      if (isInterstitialAvailable == true) {
        final isCapped = await IronSource.isInterstitialPlacementCapped(placementName: "Default");
        log('Interstitial Default placement capped: $isCapped');
        if (!isCapped && await IronSource.isInterstitialReady()) {
          log('Executing code...');
          prefs.remove(AppConst.adTimeStamp2);
          prefs.setString(AppConst.adTimeStamp2, now.toIso8601String());
          IronSource.showInterstitial();
          if (interstitialClosed == true) {
            onPressed();
          }
        }
      } else {
        onPressed();
      }
    } else {
      log('Button clicked within the last 10 minute. Not executing code2.');
      onPressed();
    }
  }

  Future<void> initAds() async {
    if (!isBannerLoaded) {
      bannerCapped = await IronSource.isBannerPlacementCapped('DefaultBanner');
      log('Banner DefaultBanner capped: $bannerCapped');
      if (!bannerCapped) {
        IronSource.loadBanner(
            size: size,
            position: IronSourceBannerPosition.Bottom,
            // verticalOffset: 40,
            verticalOffset: -(MediaQuery.of(context).size.height * 0.022)
                .toInt(),
            placementName: 'DefaultBanner');
        log('banner displayed');
        IronSource.displayBanner();
        interstitialClosed = true;
        IronSource.setInterstitialListener(this);
        IronSource.loadInterstitial();
      }
    } else {
      interstitialClosed = true;
    }
  }

  /// Interstitial listener ==================================================================================
  @override
  void onInterstitialAdClicked() {
    log("onInterstitialAdClicked");
  }

  @override
  void onInterstitialAdClosed() {
    log("onInterstitialAdClosed");
    if (mounted) {
      setState(() {
        isInterstitialAvailable = false;
        interstitialClosed = true;
      });
    }
    log(interstitialClosed.toString());
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    log("onInterstitialAdLoadFailed Error:$error");
    if (mounted) {
      setState(() {
        isInterstitialAvailable = false;
        interstitialClosed = true;
      });
    }
  }

  @override
  void onInterstitialAdOpened() {
    log("onInterstitialAdOpened");
  }

  @override
  void onInterstitialAdReady() {
    log("onInterstitialAdReady");
    if (mounted) {
      setState(() {
        isInterstitialAvailable = true;
      });
    }
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    log("onInterstitialAdShowFailed Error:$error");
    if (mounted) {
      setState(() {
        isInterstitialAvailable = false;
        interstitialClosed = true;
      });
    }
  }

  @override
  void onInterstitialAdShowSucceeded() {
    log("onInterstitialAdShowSucceeded");
  }

  /// Banner listener ==================================================================================
  @override
  void onBannerAdClicked() {
    log("onBannerAdClicked");
  }

  @override
  void onBannerAdLoadFailed(IronSourceError error) {
    log("onBannerAdLoadFailed Error:$error");
    if (mounted) {
      setState(() {
        isBannerLoaded = false;
      });
    }
  }

  @override
  void onBannerAdLoaded() {
    log("onBannerAdLoaded");
    if (mounted) {
      setState(() {
        isBannerLoaded = true;
      });
    }
  }

  @override
  void onBannerAdScreenDismissed() {
    log("onBannerAdScreenDismissed");
  }

  @override
  void onBannerAdScreenPresented() {
    log("onBannerAdScreenPresented");
  }

  @override
  void onBannerAdLeftApplication() {
    log("onBannerAdLeftApplication");
  }

}