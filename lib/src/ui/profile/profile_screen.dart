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
                            onPressed: () => {Navigator.of(context).pop()},
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
                              con.logout(() {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }), ModalRoute.withName('/'));
                              });
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
                                  image: con.userData.photoUrl == null
                                      ? AssetImage(
                                          "lib/resources/images/google_logo.png")
                                      : NetworkImage(con.userData.photoUrl),
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
                                    Column(children: <Widget>[
                                      buildDropDown(
                                        <String>[
                                          'Male',
                                          'Female',
                                        ],
                                        " Gender",
                                        con.userData.gender,
                                        (v) {
                                          con.genderChange(v);
                                        },
                                      ),
                                      buildDropDown(
                                        <String>[
                                          for (var i = 40; i <= 200; i += 5)
                                            "$i kg"
                                        ],
                                        "  Weight",
                                        con.userData.weight,
                                        (v) {
                                          con.weightChange(v);
                                        },
                                      ),
                                    ]),
                                    Column(
                                      children: <Widget>[
                                        buildDropDown(<String>[
                                          for (var i = DateTime.now().year;
                                              i >= 1900;
                                              i--)
                                            "$i"
                                        ], "Bithdate", con.userData.bithDate,
                                            (v) {
                                          con.bithDateChange(v);
                                        }, datePicker: true),
                                        buildDropDown(
                                          <String>[
                                            for (var i = 70; i <= 240; i += 5)
                                              "$i cm"
                                          ],
                                          "    Heigh",
                                          con.userData.height,
                                          (v) {
                                            con.heightChange(v);
                                          },
                                        ),
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
                                  onPressed: () {
                                    con.saveUserdata(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                )),
                          ])))
            ])));
  }

  Widget buildDropDown(
      List<String> items, String hint, String value, Function(String) onChanged,
      {bool datePicker = false}) {
    return SizedBox(
        width: 110,
        child: Theme(
            data: Theme.of(context).copyWith(
                buttonTheme: ButtonTheme.of(context).copyWith(
              padding: EdgeInsets.all(0),
              alignedDropdown: true,
            )),
            child: DropdownButton<String>(
                iconSize: 30,
                icon: Icon(
                  datePicker ? Icons.date_range : Icons.arrow_drop_down,
                  color: Color(0xff010101),
                  size: datePicker ? 20 : 24,
                ),
                hint: Text(
                  hint,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff010101)),
                  textAlign: TextAlign.center,
                ),
                value: value,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: <Widget>[
                        Text(
                          item,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff010101)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: onChanged)));
  }
}
