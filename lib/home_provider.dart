import 'dart:math';

import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool isMale = true;
  double weight = 35;
  int age = 18;
  double heightVal = 150;
  double result = 100;
  String resultText = '';

  void changeHeightVal(double hV) {
    heightVal = hV;
    notifyListeners();
  }

  void changeIsMale(String type) {
    isMale = (type == 'Male') ? true : false;
    notifyListeners();
  }

  void decreaseAgeOrWeight(String type) {
    type == 'age' ? age-- : weight--;
    notifyListeners();
  }

  void increaseAgeOrWeight(String type) {
    type == 'age' ? age++ : weight++;
    notifyListeners();
  }

  void Health() {
    result = weight / pow(heightVal / 100, 2);
    if (result >= 30)
      resultText = 'Obese';
    else if (result >= 25)
      resultText = 'overwight';
    else if (result >= 18.5) {
      resultText = 'Normal';
    } else {
      resultText = 'Underwight';
    }
    notifyListeners();
  }
}
