import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAds {
  static final showTestAds = true;

  static final banner_ad_real = showTestAds
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-2562103839684165/9675411289";
  static final interstital_ad_real = showTestAds
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-2562103839684165/6195385172";
  static final reward_ad_real = showTestAds
      ? "ca-app-pub-3940256099942544/5224354917"
      : "ca-app-pub-2562103839684165/5784074217";


  BannerAd myBanner;
  InterstitialAd interstitialAd;
  RewardedAd rewardedAd;

  Container bannerAd() {
    myBanner = BannerAd(
      adUnitId: banner_ad_real,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();
    AdWidget adWidget = AdWidget(ad: myBanner);


    Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: double.infinity,
      height: 100,
    );

    return adContainer;
  }

  loadInterstitialAd() {
    print("interstital " + interstital_ad_real);
    InterstitialAd.load(
        adUnitId:interstital_ad_real,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            this.interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd.show();
    } else {
      loadInterstitialAd();
      ///// TODO: remove Add//////////
      // interstitialAd.show();
    }
  }

  loadRewardAds() {
    print("reward " + reward_ad_real);
    RewardedAd.load(
        adUnitId: reward_ad_real,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            this.rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  showRewardAds() {
    if (rewardedAd != null) {
      rewardedAd.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
        // Reward the user for watching an ad.
      });
    } else {
      loadRewardAds();
      rewardedAd.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
        // Reward the user for watching an ad.
      });
    }
  }

  disposeBanner() {
    if (myBanner != null) myBanner.dispose();
  }

  disposeInterstitialAd() {
    if (interstitialAd != null) interstitialAd.dispose();
  }

  disposeRewardAd() {
    if (rewardedAd != null) rewardedAd.dispose();
  }
}
