import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:webview/value.dart';
import 'adprovider.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdProvider()),
        ChangeNotifierProvider(create: (context) => ValueProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WebViewApp(),
      ),
    );
  }
}
