import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider with ChangeNotifier {
  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;
  final String bannerAdId = "ca-app-pub-3583408987963616/9617999363";

  late InterstitialAd interstitialAd;
  bool isInterstitialAdLoaded = false;
  final String interstitialAdId = "ca-app-pub-3583408987963616/3591377562";

  void initilizedBannerAd() async {
    bannerAd = BannerAd(
      adUnitId: bannerAdId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        debugPrint("Banner AD Loaded!");
        debugPrint(
            "----------------------------------------------------------------------------------------------------------");
        isBannerAdLoaded = true;
        notifyListeners();
      }, onAdClosed: (ad) {
        ad.dispose();
        isBannerAdLoaded = false;
      }, onAdFailedToLoad: (ad, err) {
        debugPrint(err.toString());
        isBannerAdLoaded = false;
      }),
    );
    await bannerAd.load();
  }

  void initilizedInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded = true;
          debugPrint("Interstitial Ad Loaded");
        },
        onAdFailedToLoad: (error) {
          debugPrint("Interstitial Ad Not Loaded");
          debugPrint(error.code.toString());
          interstitialAd.dispose();
        },
      ),
    );
    notifyListeners();
  }
}
