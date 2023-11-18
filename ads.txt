main.dart

class _MyAppState extends State<MyApp> with IronSourceImpressionDataListener, IronSourceInitializationListener {

  @override
  void initState() {
    initIronSource();
    super.initState();
  }

  Future<void> initIronSource() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConst.adTimeStamp1);
    prefs.remove(AppConst.adTimeStamp2);
    final appKey = Platform.isAndroid
    // ? "85460dcd"
        ? AppConst.APP_KEY_IRON_SOURCE
        : throw Exception("Unsupported Platform");

    try {
      IronSource.setFlutterVersion(versionController.packageInfo.version); // fetch automatically
      IronSource.setImpressionDataListener(this);
      await enableDebug();
      await IronSource.shouldTrackNetworkState(true);

      // GDPR, CCPA, COPPA etc
      await setRegulationParams();

      // Segment info
      // await setSegment();

      // For Offerwall
      // Must be called before init
      // await IronSource.setClientSideCallbacks(true);

      // GAID, IDFA, IDFV
      String id = await IronSource.getAdvertiserId();
      print('AdvertiserID: $id');

      // Do not use AdvertiserID for this.
      //  offerwall ad unit or using server-to-server callbacks to reward your users
      // await IronSource.setUserId(AppConst.APP_USER_ID);

      // Finally, initialize
      await IronSource.init(
          appKey: appKey,
          adUnits: [
            IronSourceAdUnit.RewardedVideo,
            IronSourceAdUnit.Interstitial,
            IronSourceAdUnit.Banner,
            IronSourceAdUnit.Offerwall,
          ],
          initListener: this);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> enableDebug() async {
    await IronSource.setAdaptersDebug(true);
    // this function doesn't have to be awaited
    IronSource.validateIntegration();
  }

  // Sample Segment Params - adsz as per user requirements
  Future<void> setSegment() {
    final segment = IronSourceSegment();
    segment.age = 20;
    segment.gender = IronSourceUserGender.Female;
    segment.level = 3;
    segment.isPaying = false;
    segment.userCreationDateInMillis = DateTime.now().millisecondsSinceEpoch;
    segment.iapTotal = 1000;
    segment.setCustom(key: 'DemoCustomKey', value: 'DemoCustomVal');
    return IronSource.setSegment(segment);
  }

  Future<void> setRegulationParams() async {
    // GDPR
    await IronSource.setConsent(true);
    await IronSource.setMetaData({
      // CCPA
      'do_not_sell': ['false'],
      // COPPA
      'is_child_directed': ['false'],
      // 'is_test_suite': ['enable']
      // 'is_test_suite': ['disable']
    });

    return;
  }

  @override
  void onImpressionSuccess(IronSourceImpressionData? impressionData) {
    log('Impression Data: $impressionData');
  }

  // Initialization listener
  @override
  void onInitializationComplete() {
    log('onInitializationComplete');
  }

}

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