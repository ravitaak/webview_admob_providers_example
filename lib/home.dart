import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'adprovider.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);
    adProvider.initilizedInterstitialAd();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://google.com'),
      );
    adProvider.initilizedBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        actions: [
          IconButton(
              onPressed: () {
                AdProvider adProvider =
                    Provider.of<AdProvider>(context, listen: false);
                if (adProvider.isInterstitialAdLoaded) {
                  adProvider.interstitialAd.show();
                } else {
                  adProvider.initilizedBannerAd();
                }
              },
              icon: const Icon(Icons.ads_click)),
          IconButton(
              onPressed: () {
                AdProvider adProvider =
                    Provider.of<AdProvider>(context, listen: false);
                adProvider.initilizedBannerAd();
              },
              icon: const Icon(Icons.cloud_circle))
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      bottomNavigationBar: Consumer<AdProvider>(
        builder: (context, value, child) {
          if (value.isBannerAdLoaded) {
            return SizedBox(
              height: value.bannerAd.size.height.toDouble(),
              width: value.bannerAd.size.width.toDouble(),
              child: AdWidget(ad: value.bannerAd),
            );
          } else {
            return const Text("Not loaded");
          }
        },
      ),
    );
  }
}
