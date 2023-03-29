import 'package:flutter/material.dart';

class ValueProvider with ChangeNotifier {
  int value1 = 0;
  int get value => value1;

  void setValue() {
    value1++;
    notifyListeners();
  }
}
