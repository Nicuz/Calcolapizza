import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/ui/screens/dough_page.dart';
import 'package:calcolapizza/ui/widgets/rounded_button.dart';
import 'package:calcolapizza/ui/widgets/title_slider.dart';
import 'package:calcolapizza/ui/widgets/title_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CalcolapizzaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalcolapizzaProvider calcolapizzaProvider =
        Provider.of<CalcolapizzaProvider>(context);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        // hide keyboard
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 40, 25, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Calcolapizza",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Column(
                    children: <Widget>[
                      TitleTextField(
                        title: AppLocalizations.of(context)
                            .translate("doughBallsNumber"),
                        fieldValue: calcolapizzaProvider.doughNumber,
                        error: AppLocalizations.of(context)
                            .translate("invalidValue"),
                      ),
                      SizedBox(height: 10.0),
                      TitleTextField(
                        title: AppLocalizations.of(context)
                            .translate("doughBallsWeight"),
                        fieldValue: calcolapizzaProvider.doughWeight,
                        error: AppLocalizations.of(context)
                            .translate("invalidValue"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TitleSlider(
                    title: AppLocalizations.of(context)
                        .translate("doughHydration"),
                    unit: "%",
                    min: 50,
                    max: 100,
                    value: calcolapizzaProvider.selectedHydration,
                    onChanged: (double updateHydration) {
                      calcolapizzaProvider.setSelectedHydration =
                          updateHydration;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("saltPerLiter"),
                          unit: "g/L",
                          min: 0,
                          max: 70,
                          value: calcolapizzaProvider.saltPerLiter,
                          onChanged: (double updateSaltPerLiter) {
                            calcolapizzaProvider.setSelectedSaltPerLiter =
                                updateSaltPerLiter;
                          },
                        ),
                      ),
                      Expanded(
                        child: TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("fatsPerLiter"),
                          unit: "g/L",
                          min: 0,
                          max: 150,
                          value: calcolapizzaProvider.fatsPerLiter,
                          onChanged: (double updateFatsPerLiter) {
                            calcolapizzaProvider.setSelectedFatsPerLiter =
                                updateFatsPerLiter;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TitleSlider(
                    title: AppLocalizations.of(context)
                        .translate("roomTemperature"),
                    unit: "°C",
                    min: 15,
                    max: 35,
                    value: calcolapizzaProvider.selectedRoomTemp,
                    onChanged: (double updateRoomTemp) {
                      calcolapizzaProvider.setSelectedRoomTemp = updateRoomTemp;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("risingTime"),
                          unit: "h",
                          min: 3,
                          max: 96,
                          value: calcolapizzaProvider.selectedRaisingTime,
                          onChanged: (double updateRaisingTime) {
                            calcolapizzaProvider.setSelectedRaisingTime =
                                updateRaisingTime;
                          },
                        ),
                      ),
                      Expanded(
                        child: TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("fridgeRisingTime"),
                          unit: "h",
                          min: 0,
                          max: calcolapizzaProvider.maxFridgeTime.toDouble(),
                          value: calcolapizzaProvider.selectedFridgeTime,
                          onChanged: (double updateFridgeTime) {
                            calcolapizzaProvider.setSelectedFridgeTime =
                                updateFridgeTime;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(AppLocalizations.of(context)
                                  .translate("grandmaPizza")),
                              Switch(
                                value: calcolapizzaProvider.isGrandmaPizza,
                                activeColor: Colors.deepOrange,
                                onChanged: (bool value) {
                                  calcolapizzaProvider.setIsGrandmaPizza =
                                      value;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.infoCircle,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("grandmaPizzaHint"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: RoundedButton(
                      text: AppLocalizations.of(context)
                          .translate("calculateRecipe"),
                      color: Colors.deepOrange,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Dough dough = Dough(
                            doughsNumber: num.parse(
                                calcolapizzaProvider.doughNumber.text),
                            doughsWeight: num.parse(
                                calcolapizzaProvider.doughWeight.text),
                            hydration: calcolapizzaProvider.selectedHydration,
                            saltPerLiter: calcolapizzaProvider.saltPerLiter,
                            fatsPerLiter: calcolapizzaProvider.fatsPerLiter,
                            roomTemp: calcolapizzaProvider.selectedRoomTemp,
                            risingTime:
                                calcolapizzaProvider.selectedRaisingTime,
                            fridgeRisingTime:
                                calcolapizzaProvider.selectedFridgeTime,
                            isGrandmaPizza: calcolapizzaProvider.isGrandmaPizza,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoughPage(DoughPageMode.Save, dough),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
