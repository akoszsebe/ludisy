import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/ui/login/login_screen.dart';
import 'package:stairstepsport/src/ui/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateMVC<ProfileScreen> {
  _ProfileScreenState() : super(ProfileController()) {
    con = controller;
  }
  ProfileController con;

  @override
  void initState() {
    super.initState();
    con.init();
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
            body: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: "back",
                            mini: true,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back,
                                color: Color(0xff7FA1F6)),
                            onPressed: () => {
                              Navigator.of(context).pop()
                            },
                          ),
                          FloatingActionButton(
                            heroTag: "logout",
                            mini: true,
                            backgroundColor: Colors.white,
                            child: Image(
                                height: 30,
                                image: AssetImage(
                                    "lib/resources/images/logout.png")),
                            onPressed: () {
                              con.logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }), ModalRoute.withName('/'));
                            },
                          ),
                        ],
                      ))),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      height: 370,
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 24),
                            ),
                            Container(
                              width: 64.0,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: NetworkImage(con.userData.photoUrl),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                border: Border.all(
                                  color: Color(0xff7FA1F6),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                            ),
                            Text(
                              "Hi ${con.userData.displayName}!",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff323232)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 11),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('thisisyourdata'),
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff010101)),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        DropdownButton<String>(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff010101),
                                          ),
                                          hint: Text(
                                            "Gender",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff010101)),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: con.userData.gender,
                                          items: <String>[
                                            'Male',
                                            'Female',
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff010101)),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            con.genderChange(v);
                                          },
                                        ),
                                        DropdownButton<String>(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff010101),
                                          ),
                                          hint: Text(
                                            "Weight",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff010101)),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: con.userData.height,
                                          items: <String>[
                                            '40 kg',
                                            '45 kg',
                                            '50 kg',
                                            '55 kg',
                                            '60 kg',
                                            '65 kg',
                                            '70 kg',
                                            '75 kg',
                                            '80 kg',
                                            '85 kg',
                                            '90 kg',
                                            '95 kg',
                                            '100 kg',
                                            '105 kg',
                                            '110 kg',
                                            '115 kg',
                                            '120 kg',
                                            '125 kg',
                                            '130 kg',
                                            '135 kg',
                                            '140 kg',
                                            '145 kg',
                                            '150 kg',
                                            '155 kg',
                                            '160 kg',
                                            '165 kg',
                                            '170 kg',
                                            '175 kg',
                                            '180 kg',
                                            '185 kg',
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff010101)),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            con.heightChange(v);
                                          },
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        DropdownButton<String>(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff010101),
                                          ),
                                          hint: Text(
                                            "Bith Date",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff010101)),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: con.userData.bithDate,
                                          items: <String>[
                                            '1995',
                                            '1996',
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff010101)),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            con.bithDateChange(v);
                                          },
                                        ),
                                        DropdownButton<String>(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff010101),
                                          ),
                                          hint: Text(
                                            "Heigh",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff010101)),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: con.userData.weight,
                                          items: <String>[
                                            '40 cm',
                                            '45 cm',
                                            '50 cm',
                                            '55 cm',
                                            '60 cm',
                                            '65 cm',
                                            '70 cm',
                                            '75 cm',
                                            '80 cm',
                                            '85 cm',
                                            '90 cm',
                                            '95 cm',
                                            '100 cm',
                                            '105 cm',
                                            '110 cm',
                                            '115 cm',
                                            '120 cm',
                                            '125 cm',
                                            '130 cm',
                                            '135 cm',
                                            '140 cm',
                                            '145 cm',
                                            '150 cm',
                                            '155 cm',
                                            '160 cm',
                                            '165 cm',
                                            '170 cm',
                                            '175 cm',
                                            '180 cm',
                                            '185 cm',
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff010101)),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            con.weightChange(v);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Transform.scale(
                                scale: 1.2,
                                child: FloatingActionButton(
                                  heroTag: "done",
                                  backgroundColor: Color(0xff7FA1F6),
                                  child: Image(
                                      height: 30,
                                      image: AssetImage(
                                          "lib/resources/images/done.png")),
                                  onPressed: () {},
                                )),
                          ])))
            ])));
  }
}
