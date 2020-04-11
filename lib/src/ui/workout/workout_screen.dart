import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/ui/workout/workout_controller.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';
import 'package:stairstepsport/src/widgets/rounded_mini_button.dart';

class WorkOutScreen extends StatefulWidget {
  final int stepPlan;
  final AppDatabase appDatabase;

  WorkOutScreen(this.appDatabase,this.stepPlan, {Key key}) : super(key: key);
  final String title = 'Flutter Demo Home Page';
  @override
  _WorkOutScreenState createState() => _WorkOutScreenState(appDatabase, stepPlan);
}

class _WorkOutScreenState extends StateMVC<WorkOutScreen> {
  _WorkOutScreenState(AppDatabase appDatabase, this.stepPlan) : super(WorkOutController(appDatabase)) {
    con = controller;
    con.setupTargetSteps(stepPlan);
  }

  final int stepPlan;
  WorkOutController con;

  @override
  void initState() {
    super.initState();
    con.initPlatformState();
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
            backgroundColor: Color.fromRGBO(127, 161, 246, 0.5),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: RoundedMiniButton(
                          "back",
                          "back.png",
                          () => con.replanWorkOut(() =>
                              NavigationModule.navigateToStartScreen(context))),
                    )
                  ],
                ),
                Center(
                    child: Column(
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 180.0,
                      backgroundColor: Colors.white,
                      lineWidth: 10.0,
                      animation: false,
                      percent: con.percentageValue,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("lib/resources/images/step.png"),
                            height: 64,
                          ),
                          Padding(padding: EdgeInsets.only(top: 9)),
                          Text(
                            "${con.stepCountValue}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 26.0),
                          ),
                          Text(
                            "${con.calCounterValue.toStringAsFixed(2)} kcal",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xff7FA1F6),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                  ],
                )),
                Padding(
                  padding: EdgeInsets.only(top: 70),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(40.0))),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundedButton(
                                "stop",
                                "stop.png",
                                () {
                                  con.doneWorkout(
                                      (steps, stepsPlaned, cal, duration) {
                                    NavigationModule
                                        .navigateToWorkoutDoneScreen(context,
                                            steps, stepsPlaned, cal, duration);
                                  });
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24, right: 24),
                                child: Container(
                                    width: 70,
                                    child: Text(
                                        "${Duration(seconds: con.durationSeconds).toString().split('.').first.substring(2, 7)}",
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xff321323),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                        ))),
                              ),
                              buildWorkoutButton(),
                            ]))),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                ),
              ],
            )));
  }

  buildWorkoutButton() {
    if (con.isWorkoutStarted)
      return RoundedButton(
        "pause",
        "pause.png",
        () {
          con.stopListening();
        },
      );
    else
      return RoundedButton(
        "start",
        "start.png",
        () {
          con.startListening();
        },
      );
  }
}
