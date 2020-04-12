import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
                      child: Container(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "${DateFormat('yyyy.MM.dd').format(con.firstDay)} - ${DateFormat('yyyy.MM.dd').format(con.lastDay)}",
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
                                AppBarChart(con.dataset, (index) {
                                  con.changeSelected(index);
                                }),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 60),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "Total Steps:",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            "${con.selectedDay.totalSteps}",
                                            style: GoogleFonts.montserrat(
                                                color: Color(0xff7FA1F7),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "Avg Steps:",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            "${con.selectedDay.totalSteps / con.selectedDay.workouts.length}",
                                            style: GoogleFonts.montserrat(
                                                color: Color(0xff7FA1F7),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ])))
                ])));
  }
}
