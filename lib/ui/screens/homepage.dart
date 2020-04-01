import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/ui/screens/about_page.dart';
import 'package:calcolapizza/ui/screens/calcolapizza_page.dart';
import 'package:calcolapizza/ui/screens/doughs_list_page.dart';
import 'package:calcolapizza/ui/widgets/bottombar.dart';
import 'package:calcolapizza/ui/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomBar(),
      drawer: SideDrawer(),
      body: SafeArea(
        child: NestedScrollView(
          controller: navigationProvider.scrollViewController,
          headerSliverBuilder: (BuildContext context, _) {
            return <Widget>[
              SliverAppBar(),
            ];
          },
          body: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).bottomAppBarColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
