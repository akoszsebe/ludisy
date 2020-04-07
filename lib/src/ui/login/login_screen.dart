import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
                      height: 240,
                      color: Colors.white,
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
                                      image: AssetImage(
                                          "lib/resources/images/google_logo.png")),
                                  onPressed: () {
                                    con.login((err) {
                                      if (err != null) {
                                        //  Navigator.pop(context);
                                      } else {
                                        //Navigator.pop(context);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StartScreen()));
                                      }
                                    });
                                  },
                                )),
                          ])))
            ])));
  }
}
