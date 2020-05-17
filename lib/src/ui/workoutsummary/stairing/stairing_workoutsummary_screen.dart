import 'package:fl_chart/fl_chart.dart';
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
import 'package:ludisy/src/widgets/app_wigdet_functions.dart';

class StairingWorkoutSummaryScreen extends StatefulWidget {
  final WorkOut workout;

  StairingWorkoutSummaryScreen(this.workout, {Key key}) : super(key: key);
  @override
  _WorkoutSummaryScreenState createState() => _WorkoutSummaryScreenState();
}

class _WorkoutSummaryScreenState extends BaseScreenState<
    StairingWorkoutSummaryScreen, StairingWorkoutSummaryController> {
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
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                              )),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 32, right: 32, top: 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                buildColorCircleTextValue3Pair(
                                    "Steps",
                                    con.selected.count.toString() + " steps/min",
                                    Color(0xCC34A853)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 40, top: 24),
                              child: Stack(children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    width: double.infinity,
                                    child: LineChart(
                                      lineChartData(),
                                      swapAnimationDuration:
                                          const Duration(milliseconds: 250),
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        child: Slider(
                                          activeColor:
                                              AppColors.instance.primary,
                                          inactiveColor: AppColors
                                              .instance.primaryWithOcupacity50,
                                          min: 0,
                                          max: ((widget.workout.data as Stairs)
                                                      .snapShots
                                                      .length -
                                                  1)
                                              .toDouble(),
                                          value: con.index.toDouble(),
                                          onChanged: (value) {
                                            setState(() {
                                              con.changePosition(widget.workout,
                                                  value.toInt());
                                            });
                                          },
                                        ))),
                              ]),
                            ),
                          ),
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

  LineChartData lineChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.textPrimary),
          margin: 16,
          getTitles: (double value) {
            return ""; // titles[value];
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 1,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      lineBarsData: linesBarData2(),
    );
  }

  Map<double, String> titles = Map();

  List<FlSpot> getSpots() {
    List<FlSpot> spots = List();
    var prev = 0;
    (widget.workout.data as Stairs).snapShots.forEach((element) {
      var steps = (element.count - prev).toDouble();
      if (steps < 0) steps = 0.0;
      spots.add(FlSpot(element.whenSec.toDouble(), steps));
      prev = element.count;
      titles[steps] = element.whenSec.toString();
    });
    if (spots.isEmpty) {
      spots.add(FlSpot(0, 0));
    }
    return spots;
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: getSpots(),
        isCurved: true,
        colors: const [
          Color(0xCC34A853),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [
            Color(0xCC34A853).withOpacity(0.3),
            Color(0xCC34A853).withOpacity(0.0)
          ],
          gradientColorStops: [0.4, 1.0],
          gradientFrom: const Offset(0, 0),
          gradientTo: const Offset(0, 1),
        ),
      ),
    ];
  }
}
