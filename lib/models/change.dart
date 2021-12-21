import 'package:flutter/widgets.dart';

class BoolChange with ChangeNotifier {
  bool isReady = false;

  ready() {
    isReady = true;
    notifyListeners();
  }
}
