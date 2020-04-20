import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickInfoBar extends StatelessWidget {
  final String name;
  final String photoUrl;
  final int steps;
  final VoidCallback onHistoryPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback onSettingsPressed;
  final bool settingVisible;
  final bool hostoryVisible;

  QuickInfoBar(this.name, this.photoUrl,
      {this.steps = 0,
      this.settingVisible = false,
      this.hostoryVisible = false,
      this.onSettingsPressed,
      this.onProfilePressed,
      this.onHistoryPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(40.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createPersonInfo("Hi, $name", photoUrl),
            SizedBox(
              width: 24,
            ),
            Visibility(
                visible: settingVisible,
                child: MaterialButton(
                  height: 48,
                  minWidth: 56,
                  padding: EdgeInsets.all(0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          height: 18,
                          image:
                              AssetImage("lib/resources/images/settings.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                        ),
                        Text(
                          "Settings",
                          style: GoogleFonts.montserrat(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7FA1F6)),
                        ),
                      ]),
                  onPressed: onSettingsPressed,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                )),
            SizedBox(
              width: 4,
            ),
            Visibility(
                visible: hostoryVisible,
                child: MaterialButton(
                  height: 48,
                  minWidth: 56,
                  padding: EdgeInsets.all(0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          height: 18,
                          image: AssetImage("lib/resources/images/history.png"),
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
                  onPressed: onHistoryPressed,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                )),
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
                      image: AssetImage("lib/resources/images/step.png"),
                      width: 25,
                      color: Color(0xff7FA1F7),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                    ),
                    Text(
                      steps == null ? "0" : steps.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7FA1F6)),
                    ),
                  ]),
              onPressed: null,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 4),
            ),
          ],
        ));
  }

  Widget _createPersonInfo(String name, String picUrl) {
    return Row(
      children: <Widget>[
        MaterialButton(
          minWidth: 48,
          padding: EdgeInsets.all(0),
          onPressed: onProfilePressed,
          child: Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: picUrl == null
                    ? AssetImage("lib/resources/images/google_logo.png")
                    : NetworkImage(picUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              border: Border.all(
                color: Color(0xff7FA1F6),
                width: 2.0,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(24.0)),
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
