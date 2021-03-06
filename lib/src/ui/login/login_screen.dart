import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/ui/login/login_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/date_picker.dart';
import 'package:ludisy/src/widgets/dropdown_item.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ludisy/src/util/ui_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen, LoginController> {
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        child: Stack(children: <Widget>[
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
            height: 270.0,
            child: ScrollablePositionedList.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
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
    ]));
  }

  Widget buildSignInWidget() {
    return ContainerWithAction(
      margin: EdgeInsets.only(bottom: 24),
      child: RoundedContainer(
          backgroundColor: AppColors.instance.containerColor,
          radius: 32.0,
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 28),
          width: MediaQuery.of(context).size.width - 32,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24),
                ),
                Text(
                  LocaleKeys.login_wellcome.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(
                  LocaleKeys.login_sign_in.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                ),
              ])),
      action: Transform.scale(
          scale: 1.2,
          child: FloatingActionButton(
            backgroundColor: AppColors.instance.containerColor,
            child: SvgPicture.asset(AppSVGAssets.googleLogo, height: 30),
            onPressed: () {
              con.login((err) {
                if (err != null) {
                } else {
                  scrollTo(1);
                }
              });
            },
          )),
    );
  }

  Widget buildUserDateWidget() {
    return ContainerWithAction(
      margin: EdgeInsets.only(bottom: 24),
      child: RoundedContainer(
        backgroundColor: AppColors.instance.containerColor,
        radius: 32.0,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        width: MediaQuery.of(context).size.width - 32,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24, left: 34, right: 34),
                child: Text(
                  LocaleKeys.login_weneedyourdata.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                ),
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
                          hintColor: con.field1
                              ? AppColors.instance.textPrimary
                              : AppColors.instance.secundary,
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
                          hintColor: con.field2
                              ? AppColors.instance.textPrimary
                              : AppColors.instance.secundary,
                        ),
                      ]),
                      Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: AppDatePicker(
                                hint: "Birthdate",
                                initDate: con.userData.bithDate,
                                showError: !con.field3,
                                onDateChanged: (date) {
                                  con.bithDateChange(date);
                                },
                              )),
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
                            hint: "Height",
                            hintColor: con.field4
                                ? AppColors.instance.textPrimary
                                : AppColors.instance.secundary,
                          ),
                        ],
                      )
                    ],
                  )),
            ]),
      ),
      action: RoundedButton(
        "next",
        AppSVGAssets.next,
        () {
          con.saveUserdata(() {
            scrollTo(2);
          });
        },
      ),
    );
  }

  Widget buildDoneWidget() {
    return ContainerWithAction(
      margin: EdgeInsets.only(bottom: 24),
      child: RoundedContainer(
          backgroundColor: AppColors.instance.containerColor,
          radius: 32.0,
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
          width: MediaQuery.of(context).size.width - 32,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24),
                ),
                Text(
                  LocaleKeys.login_congratulation.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(
                  LocaleKeys.login_letsdosomesteps.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 104),
                ),
              ])),
      action: RoundedButton(
        "done",
        AppSVGAssets.done,
        () {
          NavigationModule.navigateToStartScreen(context);
        },
      ),
    );
  }

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic);
}
