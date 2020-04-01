import 'package:animations/animations.dart';
import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/ui/screens/dough_page.dart';
import 'package:calcolapizza/ui/widgets/dough_card_detail.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:calcolapizza/enums.dart';

extension on Widget {
  Widget marginVertical(double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }
}

class DoughsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DoughDetailsProvider doughDetailsProvider =
        Provider.of<DoughDetailsProvider>(context);

    return FutureBuilder<List>(
      future: doughDetailsProvider.getDoughs(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: FlareActor(
                        "assets/images/no_data_pizza.flr",
                        fit: BoxFit.cover,
                        animation: "bounce",
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).translate("noDoughsSaved"),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Dough item = Dough.fromMap(snapshot.data[index]);
                          return OpenContainer(
                            openColor: Colors.transparent,
                            openElevation: 0,
                            closedColor: Colors.transparent,
                            closedElevation: 0,
                            transitionDuration: Duration(milliseconds: 350),
                            closedBuilder:
                                (BuildContext context, VoidCallback action) {
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    title: Text(item.doughName),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        DoughCardDetail(
                                          icon: FontAwesomeIcons.pizzaSlice,
                                          iconColor: Colors.red[400],
                                          text: item.doughsNumber == 1
                                              ? "${item.doughsNumber} ${AppLocalizations.of(context).translate("doughBallSingular")}"
                                              : "${item.doughsNumber} ${AppLocalizations.of(context).translate("doughBallPlural")}",
                                        ),
                                        SizedBox(height: 10),
                                        DoughCardDetail(
                                          icon: FontAwesomeIcons.balanceScale,
                                          iconColor: Colors.blueGrey,
                                          text: "${item.doughsWeight}g",
                                        ),
                                        SizedBox(height: 10),
                                        DoughCardDetail(
                                          icon: FontAwesomeIcons.tint,
                                          iconColor: Colors.blueAccent,
                                          text:
                                              "${item.hydration}% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}",
                                        ),
                                        Visibility(
                                          visible: item.isGrandmaPizza == 1
                                              ? true
                                              : false,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              DoughCardDetail(
                                                icon: FontAwesomeIcons
                                                    .questionCircle,
                                                iconColor: Colors.grey,
                                                text:
                                                    "${AppLocalizations.of(context).translate("grandmaPizza")}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            openBuilder:
                                (BuildContext context, VoidCallback action) =>
                                    DoughPage(
                                        DoughPageMode.view,
                                        item.roomTemp >= 59
                                            ? TempUnit.fahrenheit
                                            : TempUnit.celsius,
                                        item),
                            tappable: true,
                          ).marginVertical(5);
                        },
                      ),
                    )
                  ],
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
