import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ludisy/src/ui/workoutsummary/stairing/stairing_workoutsummary_controller.dart';

class StairingWorkoutSummaryScreen extends StatefulWidget {
  final WorkOut workout;

  StairingWorkoutSummaryScreen(this.workout, {Key key}) : super(key: key);
  @override
  _WorkoutSummaryScreenState createState() => _WorkoutSummaryScreenState();
}

class _WorkoutSummaryScreenState extends BaseScreenState<StairingWorkoutSummaryScreen,
    StairingWorkoutSummaryController> {
  _WorkoutSummaryScreenState() : super();

  final dateformat = new DateFormat('dd-MM-yyyy hh:mm');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        bacgroundColor: AppColors.instance.primaryWithOcupacity50,
        child: Column(
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
                        NavigationModule.pop(context);
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            ContainerWithActionAndLeading(
                leading: Container(
                  decoration: BoxDecoration(
                    color: AppColors.instance.containerColor,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  width: 64.0,
                  height: 64.0,
                  child: SvgPicture.asset(
                    AppSVGAssets.stairing,
                    color: AppColors.instance.primary,
                    height: 17,
                    width: 17,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                height: 400,
                margin: EdgeInsets.only(bottom: 24),
                child: RoundedContainer(
                    height: 400,
                    width: double.infinity,
                    backgroundColor: AppColors.instance.containerColor,
                    radius: 32.0,
                    margin: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 24),
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "Summary",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.instance.textPrimary),
                          ),
                          Text(
                            dateformat.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    widget.workout.timeStamp)),
                            style: GoogleFonts.montserrat(
                                fontSize: 10.0,
                                fontWeight: FontWeight.normal,
                                color: AppColors.instance.textPrimary),
                          ),
                          SizedBox(height:16),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              buildIconTextValue3Pair(
                                  "Duration",
                                  Duration(seconds: widget.workout.duration)
                                      .toString()
                                      .split('.')
                                      .first
                                      .substring(0, 7),
                                  AppSVGAssets.stopper),
                              buildIconTextValue3Pair(
                                  "Calories",
                                  "${widget.workout.cal.toStringAsFixed(0)} cal",
                                  AppSVGAssets.cal),
                              buildIconTextValue3Pair(
                                  "Avg. Stairs",
                                  widget.workout.duration <= 60
                                      ? "-  stp/min"
                                      : "${((widget.workout.data as Stairs).stairsCount / (widget.workout.duration / 60)).toStringAsFixed(0)} stp/min",
                                  AppSVGAssets.step),
                              buildIconTextValue3Pair(
                                  "Stairs",
                                  "${(widget.workout.data as Stairs).stairsCount} stp",
                                  AppSVGAssets.step)
                            ],
                          )
                        ],
                      ),
                    )),
                action: RoundedButton(
                  "done",
                  AppSVGAssets.done,
                  () => NavigationModule.pop(context),
                )),
          ],
        ));
  }

  Widget buildIconTextValue3Pair(String text, String value, String iconName) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          SvgPicture.asset(
            iconName,
            color: AppColors.instance.iconSecundary,
            height: 23,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style: GoogleFonts.montserrat(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.textPrimary),
              ),
              Text(
                value,
                style: GoogleFonts.montserrat(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.primary),
              ),
            ],
          )
        ]));
  }
}
