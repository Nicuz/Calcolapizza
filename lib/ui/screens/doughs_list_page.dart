import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/ui/screens/dough_page.dart';
import 'package:calcolapizza/ui/widgets/dough_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
                    Image.asset("assets/images/no_data_pizza.png"),
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
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Dough item = Dough.fromMap(snapshot.data[index]);
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoughPage(DoughPageMode.View, item),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 20,
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
                              ),
                            ),
                          );
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
