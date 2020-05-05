import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/ui/workoutdone/workoutdone_controller.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';

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

class _WorkOutDoneScreenState
    extends BaseScreenState<WorkOutDoneScreen, WorkOutDoneController> {
  _WorkOutDoneScreenState(
      int steps, int stepsPlaned, double cal, int durationSeconds)
      : super() {
    con.setUpValues(steps, stepsPlaned, cal, durationSeconds);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        bacgroundColor: AppColors.blueWithOcupacity50,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
                child: Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('workoutdone.congratulation'),
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
                      SvgPicture.asset(
                        AppSVGAssets.done,
                        height: 48,
                      ),
                      Padding(padding: EdgeInsets.only(top: 9)),
                      Text(
                        "${con.steps}",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 26.0),
                      ),
                      Text(
                        "${con.cal.toStringAsFixed(0)} cal",
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
              padding: EdgeInsets.only(top: 60),
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
                              AppSVGAssets.reload,
                              () => NavigationModule
                                  .navigateAndReplaceToWorkoutScreen(
                                      context, con.stepsPlaned)),
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
                          RoundedButton(
                            "done",
                            AppSVGAssets.done,
                            () => NavigationModule.pop(context),
                          )
                        ]))),
            Padding(
              padding: EdgeInsets.only(top: 100),
            ),
          ],
        ));
  }
}
