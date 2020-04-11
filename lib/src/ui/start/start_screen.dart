import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/ui/start/start_controller.dart';
import 'package:stairstepsport/src/widgets/quickinfobar.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';
import 'package:stairstepsport/src/widgets/workout_slider.dart';

class StartScreen extends StatefulWidget {
  final AppDatabase appDatabase;
  StartScreen(this.appDatabase, {Key key}) : super(key: key);
  @override
  _StartScreenState createState() => _StartScreenState(appDatabase);
}

class _StartScreenState extends StateMVC<StartScreen> {
  _StartScreenState(AppDatabase appDatabase)
      : super(StartController(appDatabase)) {
    con = controller;
  }
  StartController con;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 24),
                    child: QuickInfoBar(
                      con.userData.displayName.split(" ")[0],
                      con.userData.photoUrl,
                      steps: con.stepCountValue,
                      onProfilePressed: () =>
                          NavigationModule.navigateToProfileScreen(context),
                      onHistoryPressed: () =>
                          NavigationModule.navigateToHistoryScreen(context),
                    )),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 24),
                              child: Column(children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Center(
                                    child: Text(
                                  AppLocalizations.of(context).tr('start_msg'),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff010101)),
                                  textAlign: TextAlign.center,
                                )),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                RoundedButton(
                                    "start",
                                    "start.png",
                                    () => con.setUp((stepPlan) =>
                                        NavigationModule
                                            .navigateToWorkoutScreen(
                                                context, stepPlan))),
                              ]))),
                    ),
                    Positioned(
                        top: 0,
                        left: 30,
                        child: WorkoutSlider((value) {
                          print("value : " + value.toString());
                          con.setDificulty(value);
                        })),
                  ],
                )
              ],
            )));
  }
}
