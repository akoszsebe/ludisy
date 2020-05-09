import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/ui/profile/profile_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';
import 'package:ludisy/src/widgets/date_picker.dart';
import 'package:ludisy/src/widgets/dialogs.dart';
import 'package:ludisy/src/widgets/dropdown_item.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ludisy/src/util/ui_utils.dart';

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
                  buildButton("Delete all data", AppColors.instance.secundary,
                      () {
                    showConfirmDialog(
                        context,
                        "Are you sure you want to delete all your data ?",
                        () {});
                  }),
                  RoundedMiniButton(
                    null,
                    AppSVGAssets.logout,
                    () {
                      con.logout(() {
                        NavigationModule.navigateToLoginScreenAndRemove(
                            context);
                      });
                    },
                    iconColor: AppColors.instance.secundary,
                  ),
                ],
              ))),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: ContainerWithActionAndLeading(
          height: 310,
          margin: EdgeInsets.only(bottom: 24),
          leading: Hero(
              tag: "user",
              child: Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: AppColors.instance.primary,
                  image: DecorationImage(
                    image: con.userData.photoUrl == null
                        ? AppAssets.splash_icon
                        : NetworkImage(con.userData.photoUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  border: Border.all(
                    color: AppColors.instance.primary,
                    width: 2.0,
                  ),
                ),
              )),
          child: RoundedContainer(
              backgroundColor: AppColors.instance.containerColor,
              radius: 32.0,
              margin: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 42),
                    ),
                    Text(
                      "Hi ${con.userData.displayName}!",
                      style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.instance.textPrimary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 11),
                    ),
                    Text(
                      LocaleKeys.profile_thisisyourdata.tr(),
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.instance.textPrimary),
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
                                hintColor: AppColors.instance.textSecundary,
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
                                hintColor: AppColors.instance.textSecundary,
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
                                  hintColor: AppColors.instance.textSecundary,
                                ),
                              ],
                            )
                          ],
                        )),
                  ])),
          action: RoundedButton(
            null,
            AppSVGAssets.done,
            () {
              con.saveUserdata(() {
                NavigationModule.pop(context);
              });
            },
          ),
        ),
      )
    ]));
  }

  Widget buildButton(String title, Color color, VoidCallback onTap) {
    return Material(
        color: AppColors.instance.containerColor,
        borderRadius: BorderRadius.all(const Radius.circular(24.0)),
        elevation: 10,
        child: InkWell(
            onTap: onTap,
            customBorder: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(24.0),
            ),
            child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: color),
                  ),
                ))));
  }
}
