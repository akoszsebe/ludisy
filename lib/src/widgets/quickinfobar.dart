import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/util/ui_utils.dart';

class QuickInfoBar extends StatelessWidget {
  final String name;
  final String photoUrl;
  final VoidCallback onHistoryPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback onSettingsPressed;
  final VoidCallback onBackPressed;
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
      this.tag,
      this.onBackPressed});

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
                  AppSVGAssets.back,
                  () {
                    if (onBackPressed == null) {
                      NavigationModule.pop(context);
                    } else {
                      onBackPressed();
                    }
                  },
                ),
              )),
          Expanded(
              child: RoundedContainer(
                  backgroundColor: AppColors.instance.containerColor,
                  height: 48,
                  radius: 40.0,
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
                                        SvgPicture.asset(
                                          AppSVGAssets.settings,
                                          height: 18,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                        ),
                                        Text(
                                          "Settings",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.instance.primary),
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
                                            SvgPicture.asset(
                                              AppSVGAssets.history,
                                              height: 18,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 2),
                                            ),
                                            Text(
                                              "History",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.instance.primary),
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
                  color: AppColors.instance.primary,
                  image: DecorationImage(
                    image: picUrl == null
                        ? AppAssets.splash_icon
                        : NetworkImage(picUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  border: Border.all(
                    color: AppColors.instance.primary,
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
              color: AppColors.instance.textSecundary),
        ),
      ],
    );
  }
}
