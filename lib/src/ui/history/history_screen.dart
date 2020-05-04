import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
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
import 'package:ludisy/src/widgets/rounded_mini_button.dart';

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
  double translateOffset = 0;
  AssetImage tabImage = AppAssets.step;
  String tabName = "";
  int selectedTab = 1;
  int touchedIndex = 6;
  static final int oneHour = 3600;

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    tabName = AppLocalizations.of(context).tr('history.steps');
    return BaseView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: 12, top: 20, bottom: 40, right: 16),
              child: QuickInfoBar(
                  con.userState.getUserData().displayName != null
                      ? con.userState.getUserData().displayName.split(" ")[0]
                      : "",
                  con.userState.getUserData().photoUrl,
                  canGoBack: true,
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
                      child: buildSelectedTab(selectedTab)))),
        ]));
  }

  Widget buildDataSection(
      List<ChartItem> chartDataSet,
      DateTime startDate,
      DateTime endDate,
      String totalValue,
      String totalTitle,
      String avgValue,
      DayModel selectedDay) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(32.0))),
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
                                  splashColor: AppColors.blueWithOcupacity50,
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    touchedIndex = 6;
                                    con.fillForWeek(con.firstDay
                                        .subtract(Duration(days: 1)));
                                  }))),
                      Text(
                        "${DateFormat('yyyy.MM.dd').format(startDate)} - ${DateFormat('yyyy.MM.dd').format(endDate)}",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
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
                                      splashColor:
                                          AppColors.blueWithOcupacity50,
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.black,
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                        Text(
                          "$totalValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Avg $totalTitle:",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                        Text(
                          "$avgValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 3),
                child: buildTableHeaders(),
              ),
              SizedBox(
                child: Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(left: 38, right: 38),
                ),
                height: 1,
              ),
              Container(
                  height: 100.0,
                  padding: EdgeInsets.only(left: 28, right: 28, top: 5),
                  child: SingleChildScrollViewWithScrollbar(
                      scrollbarColor: selectedDay.workouts.length <= 4
                          ? Colors.transparent
                          : AppColors.blueWithOcupacity50,
                      scrollbarThickness: 2.0,
                      child: Table(
                        children: [
                          if (selectedDay != null)
                            for (var i = 0;
                                i < selectedDay.workouts.length;
                                i++)
                              TableRow(children: [
                                buildRowItem(
                                    "${(selectedDay.workouts[i].data as Stairs).stairsCount}"),
                                buildRowItem(
                                    "${selectedDay.workouts[i].cal.toStringAsFixed(0)} cal"),
                                buildRowItem(
                                    "${selectedDay.workouts[i].duration >= oneHour ? Duration(seconds: selectedDay.workouts[i].duration).toString().split('.').first.substring(0, 7) : Duration(seconds: selectedDay.workouts[i].duration).toString().split('.').first.substring(2, 7)}"),
                                buildRowItem(
                                    "${DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(selectedDay.workouts[i].timeStamp))}"),
                              ]),
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 8),
                  child: Container(
                      height: 70,
                      child: Stack(children: <Widget>[
                        Center(
                            child: Container(
                          height: 50,
                          width: 300,
                          decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(40.0))),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  buildBottomNavButton(
                                      selectedTab != 0, AppAssets.time, "Time",
                                      () {
                                    setState(() {
                                      translateOffset = -96;
                                      tabName = AppLocalizations.of(context)
                                          .tr('history.time');
                                      tabImage = AppAssets.time;
                                      selectedTab = 0;
                                    });
                                  }),
                                  buildBottomNavButton(
                                      selectedTab != 1, AppAssets.step, "Steps",
                                      () {
                                    setState(() {
                                      translateOffset = 0;
                                      tabName = AppLocalizations.of(context)
                                          .tr('history.steps');
                                      tabImage = AppAssets.step;
                                      selectedTab = 1;
                                    });
                                  }),
                                  buildBottomNavButton(selectedTab != 2,
                                      AppAssets.cal, "Calories", () {
                                    setState(() {
                                      translateOffset = 96;
                                      tabName = AppLocalizations.of(context)
                                          .tr('history.calories');
                                      tabImage = AppAssets.cal;
                                      selectedTab = 2;
                                    });
                                  }),
                                ],
                              )),
                        )),
                        Transform.translate(
                            offset: Offset(translateOffset, -25),
                            child: Center(
                                child: ClipPath(
                              clipper: CustomHalfCircleClipper(),
                              child: Container(
                                height: 71.0,
                                width: 55.0,
                                margin: EdgeInsets.only(
                                    bottom: 3, left: 3, right: 3),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(150.0)),
                              ),
                            ))),
                        Transform.translate(
                            offset: Offset(translateOffset, -20),
                            child: Center(
                                child: FloatingActionButton(
                                    heroTag: null,
                                    backgroundColor: AppColors.blue,
                                    elevation: 0,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                            height: 18,
                                            width: 18,
                                            color: Colors.white,
                                            image: tabImage,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "$tabName",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.0),
                                          ),
                                        ]),
                                    onPressed: null))),
                      ])))
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
                            color: AppColors.blue,
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

  Widget buildTableHeaders() {
    return Table(children: [
      TableRow(children: [
        buildTitleRowItem(AppLocalizations.of(context).tr('history.steps')),
        buildTitleRowItem(AppLocalizations.of(context).tr('history.calories')),
        buildTitleRowItem(AppLocalizations.of(context).tr('history.time')),
        buildTitleRowItem(AppLocalizations.of(context).tr('history.clock')),
      ])
    ]);
  }

  Widget buildTitleRowItem(String title) {
    return Center(
        child: Text(title,
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14.0)));
  }

  Widget buildRowItem(String text) {
    return Center(
        heightFactor: 1.3,
        child: Text(text,
            style: GoogleFonts.montserrat(
                color: AppColors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 14.0)));
  }

  Widget buildBottomNavButton(
      bool visible, AssetImage res, String title, onPressed) {
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
                      Image(
                        height: 18,
                        width: 18,
                        color: AppColors.blue,
                        image: res,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ]),
                onPressed: onPressed)));
  }

  Widget buildSelectedTab(selectedTab) {
    var avgTime = con.selectedDay.totalTimes ~/
        (con.selectedDay.workouts.length == 0
            ? 1
            : con.selectedDay.workouts.length);
    switch (selectedTab) {
      case 0:
        return buildDataSection(
            con.itemsTimes,
            con.firstDay,
            con.lastDay,
            con.selectedDay.totalTimes >= oneHour
                ? Duration(seconds: con.selectedDay.totalTimes)
                    .toString()
                    .split('.')
                    .first
                    .substring(0, 7)
                : Duration(seconds: con.selectedDay.totalTimes)
                    .toString()
                    .split('.')
                    .first
                    .substring(2, 7),
            AppLocalizations.of(context).tr('history.time'),
            avgTime >= oneHour
                ? Duration(seconds: avgTime)
                    .toString()
                    .split('.')
                    .first
                    .substring(0, 7)
                : Duration(seconds: avgTime)
                    .toString()
                    .split('.')
                    .first
                    .substring(2, 7),
            con.selectedDay);
      case 1:
        return buildDataSection(
            con.itemsSteps,
            con.firstDay,
            con.lastDay,
            con.selectedDay.totalSteps.toString(),
            AppLocalizations.of(context).tr('history.steps'),
            (con.selectedDay.totalSteps /
                    (con.selectedDay.workouts.length == 0
                        ? 1
                        : con.selectedDay.workouts.length))
                .toStringAsFixed(0),
            con.selectedDay);
      case 2:
        return buildDataSection(
            con.itemsCals,
            con.firstDay,
            con.lastDay,
            con.selectedDay.totalCals.toInt().toString(),
            AppLocalizations.of(context).tr('history.calories'),
            (con.selectedDay.totalCals.toInt() /
                    (con.selectedDay.workouts.length == 0
                        ? 1
                        : con.selectedDay.workouts.length))
                .toStringAsFixed(0),
            con.selectedDay);
    }
    return Container();
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
