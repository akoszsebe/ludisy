import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/ui/profile/profile_controller.dart';
import 'package:stairstepsport/src/widgets/dropdown_item.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';
import 'package:stairstepsport/src/widgets/rounded_mini_button.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';

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
                          RoundedMiniButton(
                            "back",
                            "back.png",
                            () {
                              NavigationModule.pop(context);
                            },
                          ),
                          RoundedMiniButton(
                            "logout",
                            "logout.png",
                            () {
                              con.logout(() {
                                NavigationModule.navigateToLoginScreen(context);
                              });
                            },
                            iconColor: const Color(0xffEA4335),
                          ),
                        ],
                      ))),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(const Radius.circular(32.0))),
                      height: 370,
                      margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
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
                                      DropDownItem(
                                        con.userData.gender == null
                                            ? null
                                            : con.userData.gender,
                                        <String>[
                                          'Male',
                                          'Female',
                                        ],
                                        (v) {
                                          con.genderChange(v);
                                        },
                                        hint: "Gender",
                                      ),
                                      DropDownItem(
                                        con.userData.weight == null
                                            ? null
                                            : "${con.userData.weight} kg",
                                        <String>[
                                          for (var i = 40; i <= 200; i += 5)
                                            "$i kg"
                                        ],
                                        (v) {
                                          con.weightChange(v);
                                        },
                                        hint: "Weight",
                                      ),
                                    ]),
                                    Column(
                                      children: <Widget>[
                                        DropDownItem(
                                          con.userData.bithDate == null
                                              ? null
                                              : con.userData.bithDate
                                                  .toString(),
                                          <String>[
                                            for (var i = DateTime.now().year;
                                                i >= 1900;
                                                i--)
                                              "$i"
                                          ],
                                          (v) {
                                            con.bithDateChange(v);
                                          },
                                          hint: "Bithdate",
                                        ),
                                        DropDownItem(
                                          con.userData.height == null
                                              ? null
                                              : "${con.userData.height} cm",
                                          <String>[
                                            for (var i = 70; i <= 240; i += 5)
                                              "$i cm"
                                          ],
                                          (v) {
                                            con.heightChange(v);
                                          },
                                          hint: "Heigh",
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            RoundedButton(
                              "done",
                              "done.png",
                              () {
                                con.saveUserdata(() {
                                  NavigationModule.pop(context);
                                });
                              },
                            ),
                          ])))
            ])));
  }
}
