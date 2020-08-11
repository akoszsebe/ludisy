import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';
import 'package:ludisy/src/ui/workout/stairing/stairing_workout_controller.dart';
import 'package:ludisy/src/widgets/count_down_widget.dart';
import 'package:ludisy/src/widgets/workout_active_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:easy_localization/easy_localization.dart';

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
          con.stopWorkout();
          print("object");
          return true;
        },
        child: BaseView(
            bacgroundColor: AppColors.instance.primaryWithOcupacity50,
            child: Stack(children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 12, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RoundedMiniButton(
                            "back",
                            AppSVGAssets.back,
                            () {
                              con.stopWorkout();
                              NavigationModule.pop(context);
                            },
                          ),
                        ],
                      )),
                  Container(
                    height: 30,
                    child: Text(
                      con.workoutState != WorkoutState.finised
                          ? ""
                          : LocaleKeys.workoutdone_congratulation.tr(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                          color: AppColors.instance.containerColor),
                    ),
                  ),
                  WorkoutActiveContainer(
                    centerDiameter: 120,
                    leftChild: buildIconTextPair(
                        "${Duration(seconds: con.durationSeconds).toString().split('.').first.substring(0, 7)}",
                        AppSVGAssets.stopper),
                    centerChild: Transform.scale(
                        scale: 1.05,
                        child: CircularPercentIndicator(
                            radius: 114.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: AppColors.instance.primary,
                            backgroundColor: AppColors.instance.containerColor,
                            lineWidth: 6.0,
                            animation: false,
                            percent: con.percentageValue,
                            center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppSVGAssets.step,
                                    color: AppColors.instance.primary,
                                    height: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                  ),
                                  Text(
                                    "${con.stepCountValue}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.instance.primary),
                                  ),
                                  Text(
                                    "stairs",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.instance.primary),
                                  ),
                                  Text(
                                    "Avg.",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.instance.textSecondary),
                                  ),
                                  RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: con.durationSeconds <= 60
                                          ? "-"
                                          : '${(con.stepCountValue / ((con.durationSeconds / 60))).toStringAsFixed(0)}',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.instance.textSecondary),
                                    ),
                                    TextSpan(
                                      text: ' stair/min',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              AppColors.instance.textSecondary),
                                    ),
                                  ])),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                  ),
                                ]))),
                    rightChild: buildIconTextPair(
                        "${con.calCounterValue.toStringAsFixed(1)} cal",
                        AppSVGAssets.cal),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 24),
                    child: buildWorkoutButton(),
                  ),
                ],
              ),
              if (con.showCounterView)
                CountdownWidget(() {
                  con.countDownFinished();
                })
            ])));
  }

  buildWorkoutButton() {
    if (con.workoutState == WorkoutState.running) {
      return RoundedButton(
        "pause",
        AppSVGAssets.pause,
        () {
          con.stopListening();
        },
      );
    } else if (con.workoutState == WorkoutState.paused) {
      return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              "stop",
              AppSVGAssets.stop,
              () {
                con.doneWorkout(() {
                  NavigationModule
                      .navigateAndReplacToStairingWorkoutSummaryScreen(
                          context, con.savedWorkout);
                });
              },
            ),
            SizedBox(
              width: 90,
            ),
            RoundedButton(
              "start_stairing",
              AppSVGAssets.start,
              () {
                con.startListening();
              },
            )
          ]);
    }
  }

  Widget buildIconTextPair(String text, String iconName) {
    return Container(
        width: 80,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                iconName,
                color: AppColors.instance.iconSecundary,
                height: 17,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.instance.primary),
              ),
            ]));
  }
}
