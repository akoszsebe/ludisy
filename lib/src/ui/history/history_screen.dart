import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
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
  double translateOffset = 0;
  String tabImage = AppSVGAssets.step;
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
    if (tabName.isEmpty) {
      tabName = tr(LocaleKeys.history_steps);
    }
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
                      EdgeInsets.only(left: 12, top: 20, bottom: 40, right: 16),
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
                          child: buildSelectedTab(selectedTab)))),
            ])));
  }

  Widget buildDataSection(
      List<ChartItem> chartDataSet,
      DateTime startDate,
      DateTime endDate,
      String totalValue,
      String totalTitle,
      String avgValue,
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
                        "${DateFormat('yyyy.MM.dd').format(startDate)} - ${DateFormat('yyyy.MM.dd').format(endDate)}",
                        style: GoogleFonts.montserrat(
                            color: AppColors.instance.textPrimary,
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
                              fontSize: 15.0),
                        ),
                        Text(
                          "$totalValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.primary,
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
                              color: AppColors.instance.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                        Text(
                          "$avgValue",
                          style: GoogleFonts.montserrat(
                              color: AppColors.instance.primary,
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
                          : AppColors.instance.primaryWithOcupacity50,
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
                            child: RoundedContainer(
                          backgroundColor: AppColors.instance.containerColor,
                          height: 50,
                          width: 300,
                          radius: 40.0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  buildBottomNavButton(
                                      selectedTab != 0,
                                      AppSVGAssets.time,
                                      LocaleKeys.history_time.tr(), () {
                                    setState(() {
                                      translateOffset = -96;
                                      tabName = LocaleKeys.history_time.tr();
                                      tabImage = AppSVGAssets.time;
                                      selectedTab = 0;
                                    });
                                  }),
                                  buildBottomNavButton(
                                      selectedTab != 1,
                                      AppSVGAssets.step,
                                      LocaleKeys.history_steps.tr(), () {
                                    setState(() {
                                      translateOffset = 0;
                                      tabName = LocaleKeys.history_steps.tr();
                                      tabImage = AppSVGAssets.step;
                                      selectedTab = 1;
                                    });
                                  }),
                                  buildBottomNavButton(
                                      selectedTab != 2,
                                      AppSVGAssets.cal,
                                      LocaleKeys.history_calories.tr(), () {
                                    setState(() {
                                      translateOffset = 96;
                                      tabName =
                                          LocaleKeys.history_calories.tr();
                                      tabImage = AppSVGAssets.cal;
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
                                    backgroundColor: AppColors.instance.primary,
                                    elevation: 0,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            tabImage,
                                            height: 18,
                                            width: 18,
                                            color: Colors.white,
                                            fit: BoxFit.scaleDown,
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

  Widget buildTableHeaders() {
    return Table(children: [
      TableRow(children: [
        buildTitleRowItem(LocaleKeys.history_steps.tr()),
        buildTitleRowItem(LocaleKeys.history_calories.tr()),
        buildTitleRowItem(LocaleKeys.history_time.tr()),
        buildTitleRowItem(LocaleKeys.history_clock.tr()),
      ])
    ]);
  }

  Widget buildTitleRowItem(String title) {
    return Center(
        child: Text(title,
            style: GoogleFonts.montserrat(
                color: AppColors.instance.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.0)));
  }

  Widget buildRowItem(String text) {
    return Center(
        heightFactor: 1.3,
        child: Text(text,
            style: GoogleFonts.montserrat(
                color: AppColors.instance.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14.0)));
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
            LocaleKeys.history_time.tr(),
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
            LocaleKeys.history_steps.tr(),
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
            LocaleKeys.history_calories.tr(),
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
