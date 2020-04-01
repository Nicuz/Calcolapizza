import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/providers/settings_provider.dart';
import 'package:calcolapizza/ui/screens/dough_page.dart';
import 'package:calcolapizza/ui/widgets/rounded_button.dart';
import 'package:calcolapizza/ui/widgets/title_slider.dart';
import 'package:calcolapizza/ui/widgets/title_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:calcolapizza/enums.dart';

class CalcolapizzaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalcolapizzaProvider calcolapizzaProvider =
        Provider.of<CalcolapizzaProvider>(context, listen: false);
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);
    final SettingsProvider settingsProvider = SettingsProvider();
    bool tempUnit = settingsProvider.getTempMode(Hive.box("settings"));
    calcolapizzaProvider.setTemperatures(tempUnit);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        // hide keyboard
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Form(
            key: _formKey,
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
                Consumer<CalcolapizzaProvider>(
                  builder: (_, calcolapizzaProvider, __) => TitleSlider(
                    title: AppLocalizations.of(context)
                        .translate("doughHydration"),
                    unit: "%",
                    min: 50,
                    max: 100,
                    value: calcolapizzaProvider.selectedHydration,
                    sliderType: SliderType.hydration,
                    onChanged: (double updateHydration) {
                      calcolapizzaProvider
                          .setSelectedHydration(updateHydration);
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Consumer<CalcolapizzaProvider>(
                        builder: (_, calcolapizzaProvider, __) => TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("saltPerLiter"),
                          unit: "g/L",
                          min: 0,
                          max: 70,
                          value: calcolapizzaProvider.saltPerLiter,
                          sliderType: SliderType.salt,
                          onChanged: (double updateSaltPerLiter) {
                            calcolapizzaProvider
                                .setSelectedSaltPerLiter(updateSaltPerLiter);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Consumer<CalcolapizzaProvider>(
                        builder: (_, calcolapizzaProvider, __) => TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("fatsPerLiter"),
                          unit: "g/L",
                          min: 0,
                          max: 150,
                          value: calcolapizzaProvider.fatsPerLiter,
                          sliderType: SliderType.fats,
                          onChanged: (double updateFatsPerLiter) {
                            calcolapizzaProvider
                                .setSelectedFatsPerLiter(updateFatsPerLiter);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Consumer<CalcolapizzaProvider>(
                  builder: (_, calcolapizzaProvider, __) => TitleSlider(
                    title: AppLocalizations.of(context)
                        .translate("roomTemperature"),
                    unit: calcolapizzaProvider.tempUnit,
                    min: calcolapizzaProvider.minRoomTemp,
                    max: calcolapizzaProvider.maxRoomTemp,
                    value: calcolapizzaProvider.selectedRoomTemp,
                    sliderType: SliderType.roomTemp,
                    onChanged: (double updateRoomTemp) {
                      calcolapizzaProvider.setSelectedRoomTemp(updateRoomTemp);
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Consumer<CalcolapizzaProvider>(
                        builder: (_, calcolapizzaProvider, __) => TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("risingTime"),
                          unit: "h",
                          min: 3,
                          max: 96,
                          value: calcolapizzaProvider.selectedRaisingTime,
                          sliderType: SliderType.risingTime,
                          onChanged: (double updateRaisingTime) {
                            calcolapizzaProvider
                                .setSelectedRisingTime(updateRaisingTime);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Consumer<CalcolapizzaProvider>(
                        builder: (_, calcolapizzaProvider, __) => TitleSlider(
                          title: AppLocalizations.of(context)
                              .translate("fridgeRisingTime"),
                          unit: "h",
                          min: 0,
                          max: calcolapizzaProvider.maxFridgeTime.toDouble(),
                          value: calcolapizzaProvider.selectedFridgeTime,
                          sliderType: SliderType.fridgeRisingTime,
                          onChanged: (double updateFridgeTime) {
                            calcolapizzaProvider
                                .setSelectedFridgeTime(updateFridgeTime);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(AppLocalizations.of(context)
                            .translate("grandmaPizza")),
                        Consumer<CalcolapizzaProvider>(
                          builder: (_, calcolapizzaProvider, __) => Switch(
                            value: calcolapizzaProvider.isGrandmaPizza,
                            activeColor: Theme.of(context).accentColor,
                            onChanged: (bool value) {
                              calcolapizzaProvider.setIsGrandmaPizza = value;
                            },
                          ),
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
                          color: Theme.of(context).accentColor,
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
                SizedBox(height: 20.0),
                Center(
                  child: RoundedButton(
                    text: AppLocalizations.of(context)
                        .translate("calculateRecipe"),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Dough dough = Dough(
                          doughsNumber:
                              num.parse(calcolapizzaProvider.doughNumber.text),
                          doughsWeight:
                              num.parse(calcolapizzaProvider.doughWeight.text),
                          hydration: calcolapizzaProvider.selectedHydration,
                          saltPerLiter: calcolapizzaProvider.saltPerLiter,
                          fatsPerLiter: calcolapizzaProvider.fatsPerLiter,
                          roomTemp: calcolapizzaProvider.selectedRoomTemp,
                          risingTime: calcolapizzaProvider.selectedRaisingTime,
                          fridgeRisingTime:
                              calcolapizzaProvider.selectedFridgeTime,
                          isGrandmaPizza: calcolapizzaProvider.isGrandmaPizza,
                          tempUnit:
                              tempUnit ? TempUnit.fahrenheit : TempUnit.celsius,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoughPage(
                                DoughPageMode.save,
                                tempUnit
                                    ? TempUnit.fahrenheit
                                    : TempUnit.celsius,
                                dough),
                          ),
                        );
                      }

                      navigationProvider.scrollViewController.animateTo(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
