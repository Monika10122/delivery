import 'package:flutter/material.dart';

class CurrentWidgetNotifier extends ChangeNotifier {
  late Widget _currentWidget = Container(); 

  Widget get currentWidget => _currentWidget;

  void updateWidget(Widget newWidget) {
    _currentWidget = newWidget;
    notifyListeners();
  }
}
