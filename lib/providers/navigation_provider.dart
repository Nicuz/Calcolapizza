import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  set setPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}
