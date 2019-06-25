import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/ui/screens/about_page.dart';
import 'package:calcolapizza/ui/screens/calcolapizza_page.dart';
import 'package:calcolapizza/ui/screens/doughs_list_page.dart';
import 'package:calcolapizza/ui/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        child: PageView(
          controller: navigationProvider.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CalcolapizzaPage(),
            DoughsListPage(),
            AboutPage(),
          ],
        ),
      ),
    );
  }
}
