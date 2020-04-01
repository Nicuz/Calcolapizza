import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/database/database.dart';
import 'package:calcolapizza/models/dough.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoughDetailsProvider with ChangeNotifier {
  final DBProvider dbProvider = DBProvider();
  bool _showAdsDivider = true;

  set setShowAdsDivider(bool value) {
    _showAdsDivider = value;
    notifyListeners();
  }

  bool get showAdsDivider => _showAdsDivider;

  void deleteDialog(BuildContext context, Dough dough) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
                AppLocalizations.of(context).translate("deleteDialogTitle")),
            content: Text(
                AppLocalizations.of(context).translate("deleteDialogMessage")),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("cancel")
                      .toUpperCase(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate("ok").toUpperCase(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteDough(context, dough.id);
                },
              )
            ],
          );
        });
  }

  void deleteDough(BuildContext context, int id) async {
    await dbProvider.deleteDough(id);
    Navigator.pop(context);
    notifyListeners();
    showFlushbar(context, Icons.check_box, Colors.teal,
        AppLocalizations.of(context).translate("deleteDialogSuccess"), 3, 80);
  }

  Future<List> getDoughs() => dbProvider.getDoughs();

  void saveDialog(BuildContext context, Dough dough) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _doughName = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title:
                Text(AppLocalizations.of(context).translate("saveDialogTitle")),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _doughName,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .translate("saveDialogTextfieldHint")),
                validator: (input) => input.trim().isEmpty
                    ? AppLocalizations.of(context).translate("requiredField")
                    : null,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("cancel")
                      .toUpperCase(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate("save").toUpperCase(),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    dough.setDoughName = _doughName.text[0].toUpperCase() +
                        _doughName.text.substring(1);
                    Navigator.of(context).pop();
                    saveDough(dough, context);
                  }
                },
              )
            ],
          );
        });
  }

  void saveDough(Dough dough, BuildContext context) {
    dbProvider.saveDough(dough);
    showFlushbar(context, Icons.check_box, Colors.teal,
        AppLocalizations.of(context).translate("saveDialogSuccess"), 3, 8);
  }

  void showFlushbar(BuildContext context, IconData icon, Color iconColor,
      String text, int duration, double bottomMargin) {
    Flushbar(
      backgroundColor: Theme.of(context).accentColor,
      shouldIconPulse: false,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      messageText: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      forwardAnimationCurve: Curves.easeIn,
      duration: Duration(seconds: duration),
    ).show(context);
  }
}
