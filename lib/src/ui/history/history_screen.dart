import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/day_model.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/ui/history/history_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/always_show_scrollbar.dart';
import 'package:ludisy/src/widgets/app_bar_chart.dart';
import 'package:ludisy/src/widgets/quickinfobar.dart';
import 'package:ludisy/src/util/ui_utils.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends StateMVC<HistoryScreen> {
  _HistoryScreenState() : super(locator<HistoryController>()) {
    con = controller;
  }
  HistoryController con;
  int touchedIndex = 6;
  static final int oneHour = 3600;

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          NavigationModule.navigateToStartScreen(context);
          return false;
        },
        child: BaseView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(left: 12, top: 20, bottom: 30, right: 16),
                  child: QuickInfoBar(
                      con.userState.getUserData().displayName != null
                          ? con.userState
                              .getUserData()
                              .displayName
                              .split(" ")[0]
                          : "",
                      con.userState.getUserData().photoUrl,
                      canGoBack: true,
                      onBackPressed: () {
                        NavigationModule.navigateToStartScreen(context);
                      },
                      onProfilePressed: () =>
                          NavigationModule.navigateToProfileScreen(context),
                      settingVisible: true,
                      onSettingsPressed: () =>
                          NavigationModule.navigateAndReplaceToSettingsScreen(
                              context))),
              Expanded(
                  child: Hero(
                      tag: "history",
                      child: Material(
                        type: MaterialType.transparency,
                        child:
                            getForSelectedWorkout(con.selelectedWorkoutIndex),
                      ))),
              Center(
                  child: Container(
                      height: 60.0,
                      margin: EdgeInsets.only(bottom: 16),
                      width: (70 * 3).toDouble(),
                      child: ListView(
                        shrinkWrap: true,
                        itemExtent: 70,
                        semanticChildCount: 20,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          buildWorkoutSelectButton(0, AppSVGAssets.stairing,
                              onTap: () {}),
                          buildWorkoutSelectButton(1, AppSVGAssets.biking,
                              onTap: () {}),
                          buildWorkoutSelectButton(2, AppSVGAssets.rollerSkates,
                              onTap: () {}),
                        ],
                      ))),
            ])));
  }

  Widget buildDataSection(
      List<ChartItem> chartDataSet,
      DateTime startDate,
      DateTime endDate,
      String totalValue,
      String totalTitle,
      String avgValue,
      List<String> firstColumnValues,
      DayModel selectedDay) {
    return RoundedContainer(
        backgroundColor: AppColors.instance.containerColor,
        radius: 32.0,
        height: 370,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        width: double.infinity,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                          width: 50,
                          height: 40,
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  customBorder: CircleBorder(),
                                  splashColor:
                                      AppColors.instance.primaryWithOcupacity50,
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: AppColors.instance.iconPrimary,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    touchedIndex = 6;
                                    con.fillForWeek(con.firstDay
                                        .subtract(Duration(days: 1)));
                                  }))),
                      Text(
                        "${DateFormat('yyyy.MM.dd').format(startDate)}  -  ${DateFormat('yyyy.MM.dd').format(endDate)}",
                        style: GoogleFonts.montserrat(
                            color: AppColors.instance.textPrimary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                      Container(
                          width: 50,
                          height: 40,
                          child: Visibility(
                              visible: con.lastDay.isBefore(
                                  DateTime.now().subtract(Duration(days: 1))),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      customBorder: CircleBorder(),
                                      splashColor: AppColors
                                          .instance.primaryWithOcupacity50,
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: AppColors.instance.iconPrimary,
                                        size: 30,
                                      ),
                                      onTap: () {
                                        touchedIndex = 6;
                                        con.fillForWeek(
                                            con.lastDay.add(Duration(days: 7)));
                                      })))),
                    ],
                  )),
              if (chartDataSet != null && chartDataSet.length != 0)
                Stack(
                  children: <Widget>[
                    AppBarChart(
                      chartDataSet,
                      touchedIndex: touchedIndex,
                    ),
                    Positioned(
                        top: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            for (int i = 0; i < 7; i++)
                              buildChartClickableOverlay(
                                  chartDataSet[touchedIndex].title,
                                  touchedIndex == i,
                                  i),
                          ],
                        ))
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Total $totalTitle:",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Text(
                          "$totalValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Avg $totalTitle:",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Text(
                          "$avgValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 3),
                child: buildTableHeaders(totalTitle),
              ),
              SizedBox(
                child: Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(left: 38, right: 38),
                ),
                height: 1,
              ),
              Container(
                  height: 120.0,
                  padding: EdgeInsets.only(left: 28, right: 28, top: 5),
                  child: SingleChildScrollViewWithScrollbar(
                      scrollbarColor: selectedDay.workouts.length <= 4
                          ? Colors.transparent
                          : AppColors.instance.primaryWithOcupacity50,
                      scrollbarThickness: 2.0,
                      child: Table(
                        children: [
                          if (selectedDay != null)
                            for (var i = 0;
                                i < selectedDay.workouts.length;
                                i++)
                              TableRow(children: [
                                buildRowItem("${firstColumnValues[i]}"),
                                buildRowItem(
                                    "${selectedDay.workouts[i].cal.toStringAsFixed(0)} cal"),
                                buildRowItem(
                                    "${selectedDay.workouts[i].duration >= oneHour ? Duration(seconds: selectedDay.workouts[i].duration).toString().split('.').first.substring(0, 7) : Duration(seconds: selectedDay.workouts[i].duration).toString().split('.').first.substring(2, 7)}"),
                                buildRowItem(
                                    "${DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(selectedDay.workouts[i].timeStamp))}"),
                                buildRowButtonItem(selectedDay.workouts[i]),
                              ]),
                        ],
                      ))),
              SizedBox(
                height: 8,
              ),
            ]));
  }

  Widget buildChartClickableOverlay(String text, bool visible, int index) {
    return GestureDetector(
        onTap: () {
          touchedIndex = index;
          con.changeSelected(touchedIndex);
        },
        child: Container(
          color: Colors.transparent,
          width: 42,
          height: 196,
          alignment: Alignment.bottomCenter,
          child: visible
              ? Stack(alignment: Alignment.center, children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 11),
                    child: CustomPaint(
                      painter: LineHalfCircleLinePainter(),
                    ),
                  ),
                  AnimatedOpacity(
                      opacity: visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 250),
                      child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.instance.primary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(text,
                                style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ))),
                ])
              : Padding(
                  padding: EdgeInsets.only(bottom: 17),
                  child: SizedBox(
                    child: Container(
                      color: Colors.grey,
                    ),
                    height: 1,
                  )),
        ));
  }

  Widget buildTableHeaders(String first) {
    return Table(children: [
      TableRow(children: [
        buildTitleRowItem(first),
        buildTitleRowItem(LocaleKeys.history_calories.tr()),
        buildTitleRowItem(LocaleKeys.history_duration.tr()),
        buildTitleRowItem(LocaleKeys.history_time.tr()),
        buildTitleRowItem("Open"),
      ])
    ]);
  }

  Widget buildTitleRowItem(String title) {
    return Center(
        child: Text(title,
            style: GoogleFonts.montserrat(
                color: AppColors.instance.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12.0)));
  }

  Widget buildRowItem(String text) {
    return Center(
        heightFactor: 1.6,
        child: Container(
            height: 24,
            alignment: Alignment.center,
            child: Text(text,
                style: GoogleFonts.montserrat(
                    color: AppColors.instance.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0))));
  }

  Widget buildRowButtonItem(WorkOut workout) {
    return Center(
        heightFactor: 1.6,
        child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.instance.containerColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    customBorder: CircleBorder(),
                    splashColor: AppColors.instance.primaryDarkWithOcupacity50,
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.instance.iconPrimary,
                      size: 18,
                    ),
                    onTap: () {
                      switch (workout.type) {
                        case 0:
                          NavigationModule
                              .navigateToStairingWorkoutSummaryScreen(
                                  context, workout);
                          break;
                        case 1:
                          NavigationModule.navigateToBikingWorkoutSummaryScreen(
                              context, workout);
                          break;
                        case 2:
                          NavigationModule.navigateToRollerSkatingWorkoutSummaryScreen(
                              context, workout);
                          break;
                        default:
                      }
                    }))));
  }

  Widget buildBottomNavButton(
      bool visible, String res, String title, onPressed) {
    return Container(
        width: 56,
        child: Visibility(
            visible: visible,
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        res,
                        height: 18,
                        width: 18,
                        color: AppColors.instance.primary,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                            color: AppColors.instance.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ]),
                onPressed: onPressed)));
  }

  Widget buildWorkoutSelectButton(int index, String imageName,
      {VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      child: RoundedButton(
        null,
        imageName,
        () {
          con.setSelelectedWorkoutIndex(index);
          onTap();
        },
        backgroundColor: con.selelectedWorkoutIndex != index
            ? AppColors.instance.containerColor
            : AppColors.instance.primary,
        iconColor: con.selelectedWorkoutIndex == index
            ? Colors.white
            : AppColors.instance.grayIconAsset,
        scale: 1,
      ),
      margin: EdgeInsets.only(left: 8, right: 8),
    );
  }

  Widget getForSelectedWorkout(int selelectedWorkoutIndex) {
    switch (selelectedWorkoutIndex) {
      case 0:
        return buildDataSection(
            con.itemsStairings,
            con.firstDay,
            con.lastDay,
            con.selectedDayStairing.totalSteps.toString(),
            LocaleKeys.history_steps.tr(),
            (con.selectedDayStairing.totalSteps /
                    (con.selectedDayStairing.workouts.length == 0
                        ? 1
                        : con.selectedDayStairing.workouts.length))
                .toStringAsFixed(0),
            getFirstColumnValuesStairing(con.selectedDayStairing.workouts),
            con.selectedDayStairing);
      case 1:
        return buildDataSection(
            con.itemsBikings,
            con.firstDay,
            con.lastDay,
            con.selectedDayBiking.totalDistance.toStringAsFixed(1) + " km",
            "Distance",
            (con.selectedDayBiking.totalDistance /
                        (con.selectedDayBiking.workouts.length == 0
                            ? 1
                            : con.selectedDayBiking.workouts.length))
                    .toStringAsFixed(0) +
                " km",
            getFirstColumnValuesBiking(con.selectedDayBiking.workouts),
            con.selectedDayBiking);
      case 2:
        return buildDataSection(
            con.itemsRollerSkatings,
            con.firstDay,
            con.lastDay,
            con.selectedDayRollerSkating.totalDistance.toStringAsFixed(1) +
                " km",
            "Distance",
            (con.selectedDayRollerSkating.totalDistance /
                        (con.selectedDayRollerSkating.workouts.length == 0
                            ? 1
                            : con.selectedDayRollerSkating.workouts.length))
                    .toStringAsFixed(0) +
                " km",
            getFirstColumnValuesRollerSkating(
                con.selectedDayRollerSkating.workouts),
            con.selectedDayRollerSkating);
      default:
        return Container();
    }
  }

  List<String> getFirstColumnValuesStairing(List<WorkOut> workouts) {
    List<String> result = List();
    workouts.forEach((element) {
      result.add((element.data as Stairs).stairsCount.toString());
    });
    return result;
  }

  List<String> getFirstColumnValuesBiking(List<WorkOut> workouts) {
    List<String> result = List();
    workouts.forEach((element) {
      result.add((element.data as Biking).distance.toStringAsFixed(1));
    });
    return result;
  }

  List<String> getFirstColumnValuesRollerSkating(List<WorkOut> workouts) {
    List<String> result = List();
    workouts.forEach((element) {
      result.add((element.data as RollerSkating).distance.toStringAsFixed(1));
    });
    return result;
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LineHalfCircleLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    {
      final p1 = Offset(-13, 0);
      final p2 = Offset(-23, 0);
      final paint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 1;
      canvas.drawLine(p1, p2, paint);
    }
    {
      final p1 = Offset(13, 0);
      final p2 = Offset(23, 0);
      final paint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 1;
      canvas.drawLine(p1, p2, paint);
    }
    {
      var paint = Paint();

      paint.color = Colors.grey;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1;

      var startPoint = Offset(-13, 0);
      var controlPoint1 = Offset(-8, -12);
      var controlPoint2 = Offset(8, -12);
      var endPoint = Offset(13, 0);

      var path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
