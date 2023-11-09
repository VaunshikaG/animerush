import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// banner ad - home, search, watchlist, account, category, details, episode

// every 5 mins
// interstitial ad (adTimeStamp1) - details, search => text_field, buttons

// every 10 mins
// rewarded interstitial ad (adTimeStamp2) - episode => init, ep no.
// rewarded vd ad (adTimeStamp3) - category, episode (ep chunks), watchlist from details pg


class AdmobController {
  bool isLive = false;

  // banner
  BannerAd? bannerAd;
  bool isBannerLoaded = false;

  final testBannerId = 'ca-app-pub-3940256099942544/6300978111';
  final liveBannerId = 'ca-app-pub-7339292071069532/8337357309';
  void loadBanner(State screenState) {
    isBannerLoaded = false;
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: isLive ? liveBannerId : testBannerId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('$ad loaded.');
          screenState.setState(() {
            isBannerLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          debugPrint('BannerAd failed to load: $err');
        },
      ),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }


  // interstitial
  InterstitialAd? interstitialAd;
  final testInterstitialId = 'ca-app-pub-3940256099942544/1033173712';
  final liveInterstitialId = 'ca-app-pub-7339292071069532/6919778942';
  void loadInterstitial() {
    InterstitialAd.load(
        adUnitId: isLive ? liveInterstitialId : testInterstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            showInterstitial(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showInterstitial(InterstitialAd ad) {
    ad.show();
  }


  // rewarded
  final testRewardedVdId = 'ca-app-pub-3940256099942544/5224354917';
  final liveRewardedVdId = 'ca-app-pub-7339292071069532/6520161990';
  void loadRewardedVd() {
    RewardedAd.load(
        adUnitId: isLive ? liveRewardedVdId : testRewardedVdId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            showRewardedVd(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void showRewardedVd(RewardedAd ad) {
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }


  // rewarded interstitial
  final testRewardedInterstitialId = 'ca-app-pub-3940256099942544/5354046379';
  final liveRewardedInterstitialId = 'ca-app-pub-7339292071069532/6545294291';
  void loadRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: isLive ? liveRewardedInterstitialId : testRewardedInterstitialId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            showRewardedInterstitialAd(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ));
  }

  void showRewardedInterstitialAd(RewardedInterstitialAd ad) {
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }


  // app open
  final testOpenAppId = 'ca-app-pub-3940256099942544/3419835294';
  final liveOpenAppId = 'ca-app-pub-7339292071069532/6276619411';
  void loadOpenAppAd() {
    AppOpenAd.load(
      adUnitId: isLive ? liveOpenAppId : testOpenAppId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          showOPenAppAd(ad);
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  void showOPenAppAd(AppOpenAd ad) {
    ad.show();
  }
}
