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
  double translateOffset = 0;
  String tabImageName = "step";
  String tabName = "Steps";
  int selectedTab = 1;
  int touchedIndex = 6;

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
                            con.userData.displayName != null
                                ? con.userData.displayName.split(" ")[0]
                                : "",
                            con.userData.photoUrl,
                            steps: con.stepCountValue,
                            onProfilePressed: () =>
                                NavigationModule.navigateToProfileScreen(
                                    context),
                          )
                        ],
                      )),
                  Expanded(child: buildSelectedTab(selectedTab)),
                  Container(
                      color: Colors.white,
                      height: 70,
                      child: Stack(children: <Widget>[
                        Center(
                            child: Container(
                          height: 40,
                          width: 250,
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
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  buildBottomNavButton(
                                      selectedTab != 0, "time", "Time", () {
                                    setState(() {
                                      translateOffset = -70;
                                      tabName = "Time";
                                      tabImageName = "time";
                                      selectedTab = 0;
                                    });
                                  }),
                                  buildBottomNavButton(
                                      selectedTab != 1, "step", "Steps", () {
                                    setState(() {
                                      translateOffset = 0;
                                      tabName = "Steps";
                                      tabImageName = "step";
                                      selectedTab = 1;
                                    });
                                  }),
                                  buildBottomNavButton(
                                      selectedTab != 2, "cal", "Calories", () {
                                    setState(() {
                                      translateOffset = 70;
                                      tabName = "Calories";
                                      tabImageName = "cal";
                                      selectedTab = 2;
                                    });
                                  }),
                                ],
                              )),
                        )),
                        Transform.translate(
                            offset: Offset(translateOffset, -20),
                            child: Center(
                                child: ClipPath(
                              clipper: CustomHalfCircleClipper(),
                              child: Container(
                                height: 59.0,
                                width: 56.0,
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
                                    backgroundColor: Color(0xff7A9FFF),
                                    elevation: 0,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                            height: 16,
                                            width: 16,
                                            color: Colors.white,
                                            image: AssetImage(
                                                "lib/resources/images/$tabImageName.png"),
                                          ),
                                          Text(
                                            "$tabName",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9.0),
                                          ),
                                        ]),
                                    onPressed: null))),
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
              AppBarChart(
                chartDataSet,
                (index) {
                  touchedIndex = index;
                  con.changeSelected(index);
                },
                touchedIndex: touchedIndex,
              ),
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

  Widget buildBottomNavButton(
      bool visible, String resName, String title, onPressed) {
    return Container(
        width: 56,
        child: Visibility(
            visible: visible,
            child: FloatingActionButton(
                heroTag: title,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        color: Color(0xff7A9FFF),
                        image: AssetImage("lib/resources/images/$resName.png"),
                      ),
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                            color: Color(0xff7A9FFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 9.0),
                      ),
                    ]),
                onPressed: onPressed)));
  }

  Widget buildSelectedTab(selectedTab) {
    switch (selectedTab) {
      case 0:
        return buildDataSection(
            con.itemsTimes,
            con.firstDay,
            con.lastDay,
            Duration(seconds: con.selectedDay.totalTimes)
                .toString()
                .split('.')
                .first
                .substring(2, 7),
            "Time",
            Duration(
                    seconds: con.selectedDay.totalTimes ~/
                        (con.selectedDay.workouts.length == 0
                            ? 1
                            : con.selectedDay.workouts.length))
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
            "Steps",
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
            "Calories",
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
