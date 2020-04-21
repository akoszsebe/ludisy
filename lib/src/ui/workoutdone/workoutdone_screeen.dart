import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stairstepsport/src/util/assets.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/ui/workoutdone/workoutdone_controller.dart';
import 'package:stairstepsport/src/util/style/colors.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';

class WorkOutDoneScreen extends StatefulWidget {
  final int steps;
  final int stepsPlaned;
  final double cal;
  final int durationSeconds;

  WorkOutDoneScreen(
      this.steps, this.stepsPlaned, this.cal, this.durationSeconds,
      {Key key})
      : super(key: key);
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
            image:
                DecorationImage(image: AppAssets.background, fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: AppColors.blueWithOcupacity50,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)
                          .tr('workoutdone.congratulation'),
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
                            image: AppAssets.done,
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
                      progressColor: AppColors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text(
                      AppLocalizations.of(context).tr('workoutdone.success1'),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, fontSize: 19.0),
                    ),
                  ],
                )),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 46),
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
                                  AppAssets.reload,
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
                                          color: AppColors.textGray,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                        ))),
                              ),
                              RoundedButton(
                                "done",
                                AppAssets.done,
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
