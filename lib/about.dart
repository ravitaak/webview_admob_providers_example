import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview/value.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ValueProvider>(context, listen: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      provider.setValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Ravi");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ValueProvider>(
            builder: (context, value, child) {
              debugPrint("He");
              return Center(
                child: Text(
                  value.value.toString(),
                  style: const TextStyle(fontSize: 50),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
