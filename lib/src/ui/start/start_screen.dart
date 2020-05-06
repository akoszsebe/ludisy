import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/ui/start/start_controller.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/quickinfobar.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/workout_quick_info.dart';
import 'package:ludisy/src/widgets/workout_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends BaseScreenState<StartScreen, StartController> {
  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: QuickInfoBar(
              con.userState.getUserData().displayName != null
                  ? con.userState.getUserData().displayName.split(" ")[0]
                  : " ",
              con.userState.getUserData().photoUrl,
              onProfilePressed: () =>
                  NavigationModule.navigateToProfileScreen(context),
              hostoryVisible: true,
              onHistoryPressed: () =>
                  NavigationModule.navigateToHistoryScreen(context),
              settingVisible: true,
              onSettingsPressed: () =>
                  NavigationModule.navigateToSettingsScreen(context),
            )),
        Center(
            child: WorkoutQuickInfoBar(
                "32", "10", "7.5", "km", "min", AppSVGAssets.stairing)),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(32.0))),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Center(
                        child: Text(
                      LocaleKeys.start_start_msg.tr(),
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack),
                      textAlign: TextAlign.center,
                    )),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    RoundedButton(
                        "start",
                        AppSVGAssets.start,
                        () => con.setUp((stepPlan) =>
                            NavigationModule.navigateToWorkoutScreen(
                                context, stepPlan))),
                  ])),
            ),
            Positioned(
                top: 0,
                left: 45,
                child: WorkoutSlider((value) {
                  con.setDificulty(value);
                })),
          ],
        )
      ],
    ));
  }
}
