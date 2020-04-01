import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/facebook_ads.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/ui/widgets/ingredient_dosage.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:calcolapizza/enums.dart';

class DoughPage extends StatelessWidget {
  final DoughPageMode _doughPageMode;
  final TempUnit _tempUnit;
  final Dough _dough;

  DoughPage(this._doughPageMode, this._tempUnit, this._dough) {
    FacebookAudienceNetwork.init(testingId: facebookTestingId);
  }

  @override
  Widget build(BuildContext context) {
    final DoughDetailsProvider doughDetailsProvider =
        Provider.of<DoughDetailsProvider>(context);

    List<Widget> _actions = [
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () {
          Share.share(_dough.shareString(context));
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          doughDetailsProvider.deleteDialog(context, _dough);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: _doughPageMode == DoughPageMode.view ? _actions : null,
      ),
      floatingActionButton: Visibility(
        visible: _doughPageMode == DoughPageMode.save ? true : false,
        child: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            doughDetailsProvider.saveDialog(context, _dough);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate("recipeTitle"),
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_dough.doughsNumber == 1
                                ? "${_dough.doughsNumber} ${AppLocalizations.of(context).translate("doughBallSingular")} (${_dough.doughsWeight}g), ${_dough.hydration}% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}"
                                : "${_dough.doughsNumber} ${AppLocalizations.of(context).translate("doughBallPlural")} (${_dough.doughsWeight}g), ${_dough.hydration}% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}"),
                            SizedBox(height: 20),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("flour"),
                              data: "${_dough.flour}g",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("water"),
                              data: "${_dough.water}g",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("saltPerLiter"),
                              data: "${_dough.salt}g",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("fatsPerLiter"),
                              data: "${_dough.fats}g",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("yeast"),
                              data:
                                  "${_dough.yeast}g (${AppLocalizations.of(context).translate("fresh")}) / ${(_dough.yeast / 2.5).toStringAsFixed(2)}g (${AppLocalizations.of(context).translate("dry")})",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("totalRisingTime"),
                              data: "${_dough.risingTime}h",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("roomTemperature"),
                              data:
                                  "${_dough.roomTemp}${_tempUnit == TempUnit.fahrenheit ? "°F" : "°C"}",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("fridgeRisingTime"),
                              data: "${_dough.fridgeRisingTime}h",
                            ),
                            SizedBox(height: 10),
                            IngredientDosage(
                              title: AppLocalizations.of(context)
                                  .translate("grandmaPizza"),
                              data: _dough.isGrandmaPizza == 1
                                  ? AppLocalizations.of(context)
                                      .translate("yes")
                                  : AppLocalizations.of(context)
                                      .translate("no"),
                            ),
                            Visibility(
                              visible: doughDetailsProvider.showAdsDivider,
                              child: Divider(),
                            ),
                            FacebookBannerAd(
                              placementId: facebookPlacementId,
                              listener: (BannerAdResult result, dynamic value) {
                                print("Banner Ad: $result --> $value");
                                doughDetailsProvider.setShowAdsDivider =
                                    result.toString() == "BannerAdResult.ERROR"
                                        ? false
                                        : true;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //TODO: Add notes
          // Visibility(
          //   visible: _doughPageMode == DoughPageMode.View ? true : false,
          //   child: DraggableScrollableSheet(
          //     initialChildSize: 0.1,
          //     minChildSize: 0.1,
          //     maxChildSize: 1,
          //     builder:
          //         (BuildContext context, ScrollController scrollController) {
          //       return Container(
          //         decoration: BoxDecoration(
          //             //color: Color(0xffFEA47F),
          //             color: Theme.of(context).bottomAppBarColor,
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(20),
          //                 topRight: Radius.circular(20))),
          //         padding: const EdgeInsets.symmetric(horizontal: 16),
          //         child: ListView(
          //           controller: scrollController,
          //           children: <Widget>[
          //             Container(
          //               height: MediaQuery.of(context).size.height * 0.1,
          //               alignment: Alignment.centerLeft,
          //               child: Text(
          //                 "Notes",
          //                 style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white),
          //               ),
          //             ),
          //             Text(
          //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          //               style: TextStyle(color: Colors.white),
          //             )
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
