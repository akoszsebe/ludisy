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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          FlatButton(
                            child: Image(
                              image: AssetImage(
                                  "lib/resources/images/history.png"),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                          Text(
                            "History",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7FA1F6)),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(top: 31),
                          child: _createPersonInfo("Hi Akos!",
                              "https://scontent-otp1-1.xx.fbcdn.net/v/t1.0-9/11214269_903830379662861_408449604046268151_n.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=owX8bXwDq_kAX9zOzyc&_nc_ht=scontent-otp1-1.xx&oh=16e90ef40c3535454c5ffa29fcf1e7b3&oe=5EAB36ED"),
                        ),
                        Column(children: <Widget>[
                          FlatButton(
                            child: Image(
                              image:
                                  AssetImage("lib/resources/images/step.png"),
                              width: 24,
                              color: Color(0xff7FA1F7),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                          Text(
                            "1287",
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7FA1F6)),
                          ),
                        ])
                      ],
                    )),
                Container(
                    decoration: new BoxDecoration(
                        color: Color(0xff7A9FFF),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                        child: Column(children: <Widget>[
                          Center(
                              child: Text(
                            AppLocalizations.of(context).tr('start_msg'),
                            style: GoogleFonts.montserrat(
                                fontSize: 33,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff010101)),
                            textAlign: TextAlign.center,
                          )),
                          Padding(padding: EdgeInsets.only(top: 50)),
                          WorkoutSlider((value) {
                            print("value : " + value.toString());
                            con.setDificulty(value);
                          }),
                          Padding(padding: EdgeInsets.only(top: 50)),
                          FloatingActionButton(
                            heroTag: "stop",
                            backgroundColor: Colors.white,
                            child: Image(
                              image:
                                  AssetImage("lib/resources/images/start.png"),
                            ),
                            onPressed: () {
                              con.setUp();
                            },
                          ),
                        ]))),
              ],
            )));
  }

  Widget _createPersonInfo(String name, String picUrl) {
    return Column(
      children: <Widget>[
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(picUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Color(0xff7FA1F6),
              width: 2.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        Text(
          name,
          style: GoogleFonts.montserrat(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff7FA1F6)),
        ),
      ],
    );
  }
}
