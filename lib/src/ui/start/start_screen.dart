import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:stairstepsport/src/ui/start/start_controller.dart';
import 'package:stairstepsport/src/widgets/workout_slider.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);
  final String title = 'Flutter Demo Home Page';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends StateMVC<StartScreen> {
  _StartScreenState() : super(StartController()) {
    con = controller;
  }
  StartController con;

  @override
  void initState() {
    super.initState();
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
                    child: Container(
                        height: 48,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(40.0))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _createPersonInfo("Hi Akos!",
                                "https://scontent-otp1-1.xx.fbcdn.net/v/t1.0-9/11214269_903830379662861_408449604046268151_n.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=owX8bXwDq_kAX9zOzyc&_nc_ht=scontent-otp1-1.xx&oh=16e90ef40c3535454c5ffa29fcf1e7b3&oe=5EAB36ED"),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                            ),
                            MaterialButton(
                              height: 48,
                              minWidth: 56,
                              padding: EdgeInsets.all(0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image(
                                      height: 18,
                                      image: AssetImage(
                                          "lib/resources/images/history.png"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                    ),
                                    Text(
                                      "History",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff7FA1F6)),
                                    ),
                                  ]),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                            ),
                            MaterialButton(
                              height: 48,
                              minWidth: 56,
                              padding: EdgeInsets.all(0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image(
                                      height: 18,
                                      image: AssetImage(
                                          "lib/resources/images/step.png"),
                                      width: 25,
                                      color: Color(0xff7FA1F7),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                    ),
                                    Text(
                                      "1287",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff7FA1F6)),
                                    ),
                                  ]),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 4),
                            ),
                          ],
                        ))),
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
                                FloatingActionButton(
                                  heroTag: "stop",
                                  backgroundColor: Color(0xff7A9FFF),
                                  child: Image(
                                    color: Colors.white,
                                    image: AssetImage(
                                        "lib/resources/images/start.png"),
                                  ),
                                  onPressed: () {
                                    con.setUp();
                                  },
                                ),
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

  Widget _createPersonInfo(String name, String picUrl) {
    return Row(
      children: <Widget>[
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(picUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(
              color: Color(0xff7FA1F6),
              width: 2.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Text(
          name,
          style: GoogleFonts.montserrat(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff323232)),
        ),
      ],
    );
  }
}
