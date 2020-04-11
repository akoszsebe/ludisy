import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/day_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/ui/history/history_controller.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/widgets/quickinfobar.dart';
import 'package:stairstepsport/src/widgets/rounded_mini_button.dart';

class HistoryScreen extends StatefulWidget {
  final AppDatabase appDatabase;
  HistoryScreen(this.appDatabase, {Key key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState(appDatabase);
}

class _HistoryScreenState extends StateMVC<HistoryScreen> {
  _HistoryScreenState(AppDatabase appDatabase)
      : super(HistoryController(appDatabase)) {
    con = controller;
  }
  HistoryController con;

  @override
  void initState() {
    super.initState();
    con.initPlatformState();
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
            backgroundColor: Colors.transparent,
            body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RoundedMiniButton(
                            "back",
                            "back.png",
                            () {
                              NavigationModule.pop(context);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          QuickInfoBar(
                            con.userData.displayName.split(" ")[0],
                            con.userData.photoUrl,
                            steps: con.stepCountValue,
                            onProfilePressed: () =>
                                NavigationModule.navigateToProfileScreen(
                                    context),
                          )
                        ],
                      )),
                  Expanded(
                      child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("data"),
                                AppBarChart(con.dataset)
                              ])))
                ])));
  }
}

class AppBarChart extends StatefulWidget {
  final List<DayModel> dataset;
  AppBarChart(this.dataset);

  @override
  State<StatefulWidget> createState() => AppBarChartState(dataset);
}

class AppBarChartState extends State<AppBarChart> {
  AppBarChartState(this.dataset);
  final Color barBackgroundColor = Colors.grey[100];
  final Duration animDuration = const Duration(milliseconds: 250);
  final List<DayModel> dataset;
  int touchedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = true,
    Color barColor = const Color(0x807FA1F6),
    double width = 16,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: isTouched ? const Color(0xff7FA1F6) : barColor,
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> list = List();
    for (var i = 0; i < dataset.length; i++) {
      list.add(makeGroupData(i, dataset[i].totalSteps.toDouble(),
          isTouched: i == touchedIndex));
    }
    return list;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem("", TextStyle(color: Colors.yellow));
            }),
        handleBuiltInTouches: false,
        touchCallback: (barTouchResponse) {
          setState(() {
            touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff010101)),
          margin: 16,
          getTitles: (double value) {
            return dataset[value.toInt()].date.toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
