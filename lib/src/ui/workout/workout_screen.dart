import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:stairstepsport/src/ui/workout/workout_controller.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';

class WorkOutScreen extends StatefulWidget {
  final int stepPlan;

  WorkOutScreen(this.stepPlan, {Key key}) : super(key: key);
  final String title = 'Flutter Demo Home Page';
  @override
  _WorkOutScreenState createState() => _WorkOutScreenState(stepPlan);
}

class _WorkOutScreenState extends StateMVC<WorkOutScreen> {
  _WorkOutScreenState(this.stepPlan) : super(WorkOutController()) {
    con = controller;
    con.setupTargetSteps(stepPlan);
  }

  final int stepPlan;
  WorkOutController con;

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
                    child: CircularPercentIndicator(
                  radius: 220.0,
                  backgroundColor: Colors.white,
                  lineWidth: 13.0,
                  animation: false,
                  percent: con.percentageValue,
                  center: Text(
                    "${con.stepCountValue} steps",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.red[800],
                )),
                Padding(
                  padding: EdgeInsets.only(top: 60),
                ),
                buildWorkoutButton(),
                RoundedButton(AppLocalizations.of(context).tr('replan_button'),
                    () {
                  con.replanWorkOut();
                }, backgroundColor: Colors.grey[900]),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            )));
  }

  buildWorkoutButton() {
    if (con.isWorkoutStarted)
      return RoundedButton(AppLocalizations.of(context).tr('stop_counting'),
          () {
        con.stopListening();
      }, backgroundColor: Theme.of(context).primaryColorDark);
    else
      return RoundedButton(AppLocalizations.of(context).tr('start_counting'),
          () {
        con.initPlatformState();
      }, backgroundColor: Theme.of(context).primaryColor);
  }
}
