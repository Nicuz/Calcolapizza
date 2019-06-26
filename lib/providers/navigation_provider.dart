import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int bottomBarIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  set setPage(int index) {
    bottomBarIndex = index;
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    notifyListeners();
  }
}
