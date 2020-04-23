import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stairstepsport/src/ui/base/base_view.dart';
import 'package:stairstepsport/src/ui/login/login_controller.dart';
import 'package:stairstepsport/src/util/assets.dart';
import 'package:stairstepsport/src/util/style/colors.dart';
import 'package:stairstepsport/src/widgets/dropdown_item.dart';
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
            height: 300.0,
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
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(32.0))),
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
                AppLocalizations.of(context).tr('login.wellcome'),
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              Text(
                AppLocalizations.of(context).tr('login.sign_in'),
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 46),
              ),
              Transform.scale(
                  scale: 1.2,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Image(height: 30, image: AppAssets.googleLogo),
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
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(32.0))),
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        width: MediaQuery.of(context).size.width - 32,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24, left: 34, right: 34),
                child: Text(
                  AppLocalizations.of(context).tr('login.weneedyourdata'),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack),
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
                          hintColor:
                              con.field1 ? AppColors.textBlack : AppColors.red,
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
                              con.field2 ? AppColors.textBlack : AppColors.red,
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
                                ? AppColors.textBlack
                                : AppColors.red,
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
                                ? AppColors.textBlack
                                : AppColors.red,
                          ),
                        ],
                      )
                    ],
                  )),
              RoundedButton(
                "next",
                AppAssets.next,
                () {
                  con.saveUserdata(() {
                    scrollTo(2);
                  });
                },
              ),
            ]));
  }

  Widget buildDoneWidget() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(32.0))),
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
                AppLocalizations.of(context).tr('login.congratulation'),
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              Text(
                AppLocalizations.of(context).tr('login.letsdosomesteps'),
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 104),
              ),
              RoundedButton(
                "done",
                AppAssets.done,
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
