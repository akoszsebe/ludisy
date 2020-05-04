import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';

class QuickInfoBar extends StatelessWidget {
  final String name;
  final String photoUrl;
  final VoidCallback onHistoryPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback onSettingsPressed;
  final bool settingVisible;
  final bool hostoryVisible;
  final bool canGoBack;
  final String tag;

  QuickInfoBar(this.name, this.photoUrl,
      {this.settingVisible = false,
      this.hostoryVisible = false,
      this.onSettingsPressed,
      this.onProfilePressed,
      this.onHistoryPressed,
      this.canGoBack = false,
      this.tag});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Visibility(
              visible: canGoBack,
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: RoundedMiniButton(
                  tag,
                  AppAssets.back,
                  () {
                    NavigationModule.pop(context);
                  },
                ),
              )),
          Expanded(
              child: Container(
                  height: 48,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(40.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _createPersonInfo("Hi, $name", photoUrl),
                      Row(children: <Widget>[
                        Visibility(
                            visible: settingVisible,
                            child: Hero(
                                tag: "settings",
                                child: MaterialButton(
                                  height: 48,
                                  minWidth: 62,
                                  padding: EdgeInsets.all(0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image(
                                          height: 18,
                                          image: AppAssets.settings,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                        ),
                                        Text(
                                          "Settings",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blue),
                                        ),
                                      ]),
                                  onPressed: onSettingsPressed,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                ))),
                        Visibility(
                            visible: hostoryVisible,
                            child: Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Hero(
                                    tag: "history",
                                    child: MaterialButton(
                                      height: 48,
                                      minWidth: 62,
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Image(
                                              height: 18,
                                              image: AppAssets.history,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 2),
                                            ),
                                            Text(
                                              "History",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blue),
                                            ),
                                          ]),
                                      onPressed: onHistoryPressed,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                    )))),
                        SizedBox(
                          width: 12,
                        )
                      ])
                    ],
                  )))
        ]);
  }

  Widget _createPersonInfo(String name, String picUrl) {
    return Row(
      children: <Widget>[
        Hero(
            tag: "user",
            child: MaterialButton(
              minWidth: 48,
              padding: EdgeInsets.all(0),
              onPressed: onProfilePressed,
              child: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  image: DecorationImage(
                    image: picUrl == null
                        ? AppAssets.googleLogo
                        : NetworkImage(picUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  border: Border.all(
                    color: AppColors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
            )),
        Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Text(
          name,
          style: GoogleFonts.montserrat(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: AppColors.textGray),
        ),
      ],
    );
  }
}
