import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/ui/workout/stairing/stairing_workout_controller.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';

class StairingWorkoutScreen extends StatefulWidget {
  final int stepPlan;

  StairingWorkoutScreen(this.stepPlan, {Key key}) : super(key: key);
  @override
  _StairingWorkoutScreenState createState() =>
      _StairingWorkoutScreenState(stepPlan);
}

class _StairingWorkoutScreenState
    extends BaseScreenState<StairingWorkoutScreen, StairingWorkoutController> {
  _StairingWorkoutScreenState(this.stepPlan) : super() {
    con.setupTargetSteps(stepPlan);
  }

  final int stepPlan;

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      con.paused();
    } else if (state == AppLifecycleState.resumed) {
      con.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          con.stopListening();
          print("object");
          return true;
        },
        child: BaseView(
            bacgroundColor: AppColors.blueWithOcupacity50,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RoundedMiniButton(
                          "back",
                          AppSVGAssets.back,
                          () {
                            con.stopListening();
                            NavigationModule.pop(context);
                          },
                        ),
                      ],
                    )),
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
                          SvgPicture.asset(
                            AppSVGAssets.step,
                            height: 64,
                          ),
                          Padding(padding: EdgeInsets.only(top: 9)),
                          Text(
                            "${con.stepCountValue}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 26.0),
                          ),
                          Text(
                            "${con.calCounterValue.toStringAsFixed(1)} cal",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: AppColors.blue,
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
                    padding: EdgeInsets.symmetric(horizontal: 46),
                    child: RoundedContainer(
                        height: 48,
                        radius: 40.0,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundedButton(
                                "stop",
                                AppSVGAssets.stop,
                                () {
                                  con.doneWorkout(
                                      (steps, stepsPlaned, cal, duration) {
                                    NavigationModule
                                        .navigateToStairingWorkoutDoneScreen(
                                            context,
                                            steps,
                                            stepsPlaned,
                                            cal,
                                            duration);
                                  });
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24, right: 24),
                                child: Container(
                                    width: 72,
                                    child: Text(
                                        "${Duration(seconds: con.durationSeconds).toString().split('.').first.substring(0, 7)}",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.textGray,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0,
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
        AppSVGAssets.pause,
        () {
          con.stopListening();
        },
      );
    else
      return RoundedButton(
        "start_stairing",
        AppSVGAssets.start,
        () {
          con.startListening();
        },
      );
  }
}
