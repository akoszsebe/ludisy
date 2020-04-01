import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:stairstepsport/src/ui/start/start_controller.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);
  final String title = 'Flutter Demo Home Page';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends StateMVC<StartScreen> {
  _StartScreenState() : super(StartController()) {
    con = controller;
  }
  StartController con;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/resources/images/stairs1.jpg"),
                fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: Colors.red.withOpacity(0.7),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Text(
                  AppLocalizations.of(context).tr('start_msg'),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                )),
                Column(children: <Widget>[
                  buildSetUpButton(
                      AppLocalizations.of(context).tr('easy_button'),
                      Colors.red,
                      Difficulty.easy),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  buildSetUpButton(
                      AppLocalizations.of(context).tr('medium_button'),
                      Colors.red[700],
                      Difficulty.normal),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  buildSetUpButton(
                      AppLocalizations.of(context).tr('hard_button'),
                      Colors.red[900],
                      Difficulty.hard),
                ]),
              ],
            )));
  }

  buildSetUpButton(String text, Color color, Difficulty difficulty) {
    return RoundedButton(text, () {
      con.setUp(difficulty);
    }, backgroundColor: color);
  }
}
