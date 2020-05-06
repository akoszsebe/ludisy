import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/ui/profile/profile_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/date_picker.dart';
import 'package:ludisy/src/widgets/dropdown_item.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends BaseScreenState<ProfileScreen, ProfileController> {
  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        child: Stack(children: <Widget>[
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundedMiniButton(
                    null,
                    AppSVGAssets.back,
                    () {
                      NavigationModule.pop(context);
                    },
                  ),
                  RoundedMiniButton(
                    null,
                    AppSVGAssets.logout,
                    () {
                      con.logout(() {
                        NavigationModule.navigateToLoginScreenAndRemove(
                            context);
                      });
                    },
                    iconColor: AppColors.red,
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
                  borderRadius: BorderRadius.all(const Radius.circular(32.0))),
              height: 370,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                    ),
                    Hero(
                        tag: "user",
                        child: Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            image: DecorationImage(
                              image: con.userData.photoUrl == null
                                  ? AppAssets.splash_icon
                                  : NetworkImage(con.userData.photoUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                            border: Border.all(
                              color: AppColors.blue,
                              width: 2.0,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    Text(
                      "Hi ${con.userData.displayName}!",
                      style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGray),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 11),
                    ),
                    Text(
                      LocaleKeys.profile_thisisyourdata.tr(),
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 28),
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
                              ),
                              DropDownItem(
                                con.userData.weight == null
                                    ? null
                                    : "${con.userData.weight} kg",
                                <String>[
                                  for (var i = 40; i <= 200; i += 5) "$i kg"
                                ],
                                (v) {
                                  con.weightChange(v);
                                },
                                hint: "Weight",
                              ),
                            ]),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: AppDatePicker(
                                    hint: "Birthdate",
                                    initDate: con.userData.bithDate,
                                    showError: false,
                                    onDateChanged: (date) {
                                      con.bithDateChange(date);
                                    },
                                  ),
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
                                ),
                              ],
                            )
                          ],
                        )),
                    RoundedButton(
                      null,
                      AppSVGAssets.done,
                      () {
                        con.saveUserdata(() {
                          NavigationModule.pop(context);
                        });
                      },
                    ),
                  ])))
    ]));
  }
}
