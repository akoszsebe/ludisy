import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/day_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/ui/history/history_controller.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/widgets/app_bar_chart.dart';
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
                      child: buildDataSection(
                          con.itemsSteps,
                          con.firstDay,
                          con.lastDay,
                          con.selectedDay.totalSteps.toString(),
                          "Steps",
                          (con.selectedDay.totalSteps /
                                  con.selectedDay.workouts.length)
                              .toStringAsFixed(0),
                          con.selectedDay)),
                  Container(
                      color: Colors.white,
                      height: 70,
                      child: Stack(children: <Widget>[
                        Center(
                            child: Container(
                          height: 40,
                          width: 200,
                          decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(40.0))),
                        )),
                        Center(
                            child: FloatingActionButton(
                                backgroundColor: Color(0xff7A9FFF),
                                onPressed: null)),
                      ]))
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
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                          icon: new Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {}),
                      Text(
                        "${DateFormat('yyyy.MM.dd').format(startDate)} - ${DateFormat('yyyy.MM.dd').format(endDate)}",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                      IconButton(
                          icon: new Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {}),
                    ],
                  )),
              AppBarChart(chartDataSet, (index) {
                con.changeSelected(index);
              }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
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
                              color: Color(0xff7FA1F7),
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
                              color: Color(0xff7FA1F7),
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
                    EdgeInsets.only(left: 50, right: 50, top: 16, bottom: 3),
                child: buildTableHeaders(),
              ),
              SizedBox(
                child: Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(left: 50, right: 50),
                ),
                height: 1,
              ),
              Container(
                  color: Colors.white,
                  height: 90.0,
                  padding: EdgeInsets.only(left: 50, right: 50, top: 5),
                  child: SingleChildScrollView(
                      child: Table(
                    children: [
                      if (selectedDay != null)
                        for (var i = 0; i < selectedDay.workouts.length; i++)
                          TableRow(children: [
                            buildRowItem("${selectedDay.workouts[i].steps}"),
                            buildRowItem(
                                "${selectedDay.workouts[i].cal.toStringAsFixed(1)} kcal"),
                            buildRowItem(
                                "${Duration(seconds: selectedDay.workouts[i].duration).toString().split('.').first.substring(2, 7)}"),
                            buildRowItem(
                                "${DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(selectedDay.workouts[i].timeStamp))}"),
                          ]),
                    ],
                  )))
            ]));
  }

  Widget buildTableHeaders() {
    return Table(children: [
      TableRow(children: [
        buildTitleRowItem("Steps"),
        buildTitleRowItem("Calories"),
        buildTitleRowItem("Time"),
        buildTitleRowItem("Clock"),
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
                color: Color(0xff7FA1F7),
                fontWeight: FontWeight.w500,
                fontSize: 14.0)));
  }
}
