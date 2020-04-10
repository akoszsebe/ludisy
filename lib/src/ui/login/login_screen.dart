import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stairstepsport/src/ui/login/login_controller.dart';
import 'package:stairstepsport/src/widgets/dropdown_item.dart';
import 'package:stairstepsport/src/widgets/loader.dart';
import 'package:stairstepsport/src/widgets/rounded_button.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';

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

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    con.checkLogin((logenIn) {
      if (logenIn == null) {
        scrollTo(2);
        return;
      }
      if (logenIn) {
        NavigationModule.navigateToStartScreen(context);
      } else {
        scrollTo(1);
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
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        switch (index) {
                          case 0:
                            return buildLoader();
                          case 1:
                            return buildSignInWidget();
                          case 2:
                            return buildUserDateWidget();
                          case 3:
                            return buildDoneWidget();
                        }
                        return Container();
                      },
                    )),
              )
            ])));
  }

  Widget buildLoader() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Loader());
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
                          scrollTo(2);
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
                          hintColor:
                              con.field1 ? Color(0xff010101) : Colors.red[300],
                        ),
                        DropDownItem(
                          con.userData.weight == null
                              ? null
                              : "${con.userData.weight.toString()} kg",
                          <String>[for (var i = 40; i <= 200; i += 5) "$i kg"],
                          (v) {
                            con.weightChange(v);
                          },
                          hint: "Weight",
                          hintColor:
                              con.field2 ? Color(0xff010101) : Colors.red[300],
                        ),
                      ]),
                      Column(
                        children: <Widget>[
                          DropDownItem(
                            con.userData.bithDate == null
                                ? null
                                : con.userData.bithDate.toString(),
                            <String>[
                              for (var i = DateTime.now().year; i >= 1900; i--)
                                "$i"
                            ],
                            (v) {
                              con.bithDateChange(v);
                            },
                            hint: "Bithdate",
                            hintColor: con.field3
                                ? Color(0xff010101)
                                : Colors.red[300],
                          ),
                          DropDownItem(
                            con.userData.height == null
                                ? null
                                : "${con.userData.height} cm",
                            <String>[
                              for (var i = 70; i <= 240; i += 5) "$i cm"
                            ],
                            (v) {
                              con.heightChange(v);
                            },
                            hint: "Heigh",
                            hintColor: con.field4
                                ? Color(0xff010101)
                                : Colors.red[300],
                          ),
                        ],
                      )
                    ],
                  )),
              RoundedButton(
                "next",
                "next.png",
                () {
                  con.saveUserdata(() {
                    scrollTo(3);
                  });
                },
              ),
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
              RoundedButton(
                "done",
                "done.png",
                () {
                  NavigationModule.navigateToStartScreen(context);
                },
              ),
            ]));
  }

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic);
}
