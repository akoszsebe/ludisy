import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stairstepsport/src/ui/login/login_controller.dart';
import 'package:stairstepsport/src/ui/start/start_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  _LoginScreenState() : super(LoginController()) {
    con = controller;
  }
  LoginController con;
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    con.checkLogin((logenIn) {
      if (logenIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => StartScreen()));
      }
    });
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
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                    height: 240.0,
                    child: ScrollablePositionedList.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        switch (index) {
                          case 0:
                            return buildSignInWidget();
                          case 1:
                            return buildUserDateWidget();
                          case 2:
                            return buildDoneWidget();
                        }
                        return Container();
                      },
                    )),
              )
            ])));
  }

  Widget buildSignInWidget() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24),
              ),
              Text(
                AppLocalizations.of(context).tr('wellcome_msg'),
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff010101)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              Text(
                AppLocalizations.of(context).tr('sign_in'),
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff010101)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 26),
              ),
              Transform.scale(
                  scale: 1.2,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Image(
                        height: 30,
                        image:
                            AssetImage("lib/resources/images/google_logo.png")),
                    onPressed: () {
                      con.login((err) {
                        if (err != null) {
                        } else {
                          scrollTo(1);
                        }
                      });
                    },
                  )),
            ]));
  }

  Widget buildUserDateWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24),
              ),
              Text(
                AppLocalizations.of(context).tr('weneedyourdata'),
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff010101)),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          <String>[for (var i = 40; i <= 200; i += 5) "$i kg"],
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
                            for (var i = DateTime.now().year; i >= 1900; i--)
                              "$i"
                          ], "Bithdate", con.userData.bithDate, (v) {
                            con.bithDateChange(v);
                          }, datePicker: true),
                          buildDropDown(
                            <String>[
                              for (var i = 70; i <= 240; i += 5) "$i cm"
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
                    heroTag: "next",
                    backgroundColor: Color(0xff7FA1F6),
                    child: Image(
                        height: 30,
                        image: AssetImage("lib/resources/images/next.png")),
                    onPressed: () {
                      con.saveUserdata(() {
                        scrollTo(2);
                      });
                    },
                  )),
            ]));
  }

  Widget buildDoneWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24),
              ),
              Text(
                AppLocalizations.of(context).tr('congratulation'),
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff010101)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              Text(
                AppLocalizations.of(context).tr('letsdosomesteps'),
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff010101)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 60),
              ),
              Transform.scale(
                  scale: 1.2,
                  child: FloatingActionButton(
                    heroTag: "done",
                    backgroundColor: Color(0xff7FA1F6),
                    child: Image(
                        height: 30,
                        image: AssetImage("lib/resources/images/done.png")),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => StartScreen()));
                    },
                  )),
            ]));
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

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic);
}
