import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int bottomBarIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollViewController = ScrollController();

  ScrollController get scrollViewController => _scrollViewController;

  PageController get pageController => _pageController;

  set setPage(int index) {
    if (index == bottomBarIndex) {
      _scrollViewController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      bottomBarIndex = index;
      _scrollViewController.jumpTo(0);
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  set setPageFromDrawer(int index) {
    bottomBarIndex = index;
    _scrollViewController.jumpTo(0);
    _pageController.jumpToPage(index);
    notifyListeners();
  }
}
