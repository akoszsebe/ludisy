import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/ui/workoutdone/workoutdone_controller.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';
import 'package:stairstepsport/src/widgets/rounded_mini_button.dart';

class WorkOutDoneScreen extends StatefulWidget {
  final int steps;
  final int stepsPlaned;
  final double cal;
  final int durationSeconds;

  WorkOutDoneScreen(this.steps, this.stepsPlaned, this.cal, this.durationSeconds,
      {Key key})
      : super(key: key);
  final String title = 'Flutter Demo Home Page';
  @override
  _WorkOutDoneScreenState createState() =>
      _WorkOutDoneScreenState(steps, stepsPlaned, cal, durationSeconds);
}

class _WorkOutDoneScreenState extends StateMVC<WorkOutDoneScreen> {
  _WorkOutDoneScreenState(
      int steps, int stepsPlaned, double cal, int durationSeconds)
      : super(WorkOutDoneController()) {
    con = controller;
    con.setUpValues(steps, stepsPlaned, cal, durationSeconds);
  }

  WorkOutDoneController con;

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
            backgroundColor: Color.fromRGBO(127, 161, 246, 0.5),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 20),
                      child: RoundedMiniButton(
                        "back",
                        "back.png",
                        () => NavigationModule.navigateToStartScreen(context),
                      ),
                    )
                  ],
                ),
                Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      "Congratulation!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, fontSize: 22.0),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
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
                            image: AssetImage("lib/resources/images/done.png"),
                            height: 48,
                          ),
                          Padding(padding: EdgeInsets.only(top: 9)),
                          Text(
                            "${con.steps}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 26.0),
                          ),
                          Text(
                            "${con.cal.toStringAsFixed(2)} kcal",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xff7FA1F6),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text(
                      "You're tough as Hulk!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, fontSize: 19.0),
                    ),
                  ],
                )),
                Padding(
                  padding: EdgeInsets.only(top: 30),
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
                                  "reload",
                                  "reload.png",
                                  () =>
                                      NavigationModule.navigateToWorkoutScreen(
                                          context, con.stepsPlaned)),
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
                              RoundedButton(
                                "done",
                                "done.png",
                                () => NavigationModule.navigateToStartScreen(
                                    context),
                              )
                            ]))),
                Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
              ],
            )));
  }
}
