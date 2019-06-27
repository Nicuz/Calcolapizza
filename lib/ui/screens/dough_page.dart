import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/facebook_ads.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/ui/widgets/ingredient_dosage.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DoughPage extends StatelessWidget {
  final DoughPageMode _doughPageMode;
  final Dough _dough;

  DoughPage(this._doughPageMode, this._dough) {
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
        actions: _doughPageMode == DoughPageMode.View ? _actions : null,
      ),
      floatingActionButton: Visibility(
        visible: _doughPageMode == DoughPageMode.Save ? true : false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.save),
            onPressed: () {
              doughDetailsProvider.saveDialog(context, _dough);
            },
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 40),
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
                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_dough.doughsNumber == 1
                              ? "${_dough.doughsNumber} ${AppLocalizations.of(context).translate("doughBallSingular")} (${_dough.doughsWeight}g), ${_dough.hydration}% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}"
                              : "${_dough.doughsNumber} ${AppLocalizations.of(context).translate("doughBallPlural")} (${_dough.doughsWeight}g), ${_dough.hydration}% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}"),
                          SizedBox(height: 20),
                          IngredientDosage(
                            title:
                                AppLocalizations.of(context).translate("flour"),
                            data: "${_dough.flour}g",
                          ),
                          SizedBox(height: 10),
                          IngredientDosage(
                            title:
                                AppLocalizations.of(context).translate("water"),
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
                            title:
                                AppLocalizations.of(context).translate("yeast"),
                            data:
                                "${_dough.yeast}g (${AppLocalizations.of(context).translate("fresh")}) / ${(_dough.yeast / 3).toStringAsFixed(2)}g (${AppLocalizations.of(context).translate("dry")})",
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
                            data: "${_dough.roomTemp}°C",
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
                                ? AppLocalizations.of(context).translate("yes")
                                : AppLocalizations.of(context).translate("no"),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum DoughPageMode { Save, View }
