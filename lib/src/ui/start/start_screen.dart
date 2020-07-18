import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/ui_state.dart';
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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ludisy/src/util/ui_utils.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends BaseScreenState<StartScreen, StartController> {
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final UiState _uiState = locator<UiState>();

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    var info =
        con.userState.getDayQuickInfoModelForType(con.selelectedWorkoutIndex);
    return BaseView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  NavigationModule.navigateAndReplaceToSettingsScreen(context),
            )),
        WorkoutQuickInfoBar(
            getTimeFormatedFrom(info.durationSec),
            info.value.toInt().toString(),
            info.avgValue.toInt().toString(),
            info.metric,
            info.durationSec >= 3600 ? "hour" : "min",
            info.imageName),
        SizedBox(
          height: 10,
        ),
        Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              height: 260.0,
              child: ScrollablePositionedList.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                initialScrollIndex: con.selelectedWorkoutIndex,
                itemBuilder: (_, index) {
                  switch (index) {
                    case 0:
                      return buildStaringWorkoutComponent();
                    case 1:
                      return builBikingWorkoutComponent();
                    case 2:
                      return builRollerSkatingWorkoutComponent();
                    case 3:
                      return builRunningWorkoutComponent();
                  }
                  return Container();
                },
              )),
          Center(
              child: Container(
                  height: 76.0,
                  margin: EdgeInsets.only(bottom: 6),
                  width: (70 * 4).toDouble(),
                  child: ListView(
                    shrinkWrap: true,
                    itemExtent: 70,
                    semanticChildCount: 20,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      buildWorkoutSelectButton(0, AppSVGAssets.stairing,
                          onTap: () {
                        setState(() {
                          _uiState.changeBackgroundImage(
                              AppAssets.background_stair);
                          scrollTo(con.selelectedWorkoutIndex);
                        });
                      }),
                      buildWorkoutSelectButton(1, AppSVGAssets.biking,
                          onTap: () {
                        setState(() {
                          _uiState
                              .changeBackgroundImage(AppAssets.background_bike);
                          scrollTo(con.selelectedWorkoutIndex);
                        });
                      }),
                      buildWorkoutSelectButton(2, AppSVGAssets.rollerSkates,
                          onTap: () {
                        setState(() {
                          _uiState.changeBackgroundImage(
                              AppAssets.background_bike);
                          scrollTo(con.selelectedWorkoutIndex);
                        });
                      }),
                      buildWorkoutSelectButton(3, AppSVGAssets.running,
                          onTap: () {
                        setState(() {
                          _uiState.changeBackgroundImage(
                              AppAssets.background_runnung);
                          scrollTo(con.selelectedWorkoutIndex);
                        });
                      }),
                    ],
                  ))),
        ]))
      ],
    ));
  }

  Widget buildWorkoutSelectButton(int index, String imageName,
      {VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      child: RoundedButton(
        null,
        imageName,
        () {
          con.setSelelectedWorkoutIndex(index);
          onTap();
        },
        backgroundColor: con.selelectedWorkoutIndex != index
            ? AppColors.instance.containerColor
            : AppColors.instance.primary,
        iconColor: con.selelectedWorkoutIndex == index
            ? Colors.white
            : AppColors.instance.grayIconAsset,
        scale: 1,
      ),
      margin: EdgeInsets.only(left: 8, right: 8),
    );
  }

  Widget buildStaringWorkoutComponent() {
    return Stack(
      children: <Widget>[
        RoundedContainer(
          backgroundColor: AppColors.instance.containerColor,
          width: MediaQuery.of(context).size.width - 32,
          margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
          radius: 32.0,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                Center(
                    child: Text(
                  LocaleKeys.start_start_staring.tr(),
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.textPrimary),
                  textAlign: TextAlign.center,
                )),
                Padding(padding: EdgeInsets.only(top: 30)),
                RoundedButton(
                    "start_stairing",
                    AppSVGAssets.start,
                    () => con.setUpStairing((stepPlan) =>
                        NavigationModule.navigateToStairingWorkoutScreen(
                            context, stepPlan))),
              ])),
        ),
        Positioned(
            top: 0,
            left: 45,
            child: WorkoutSlider((value) {
              con.setDificulty(value);
            }, <String>['100', '250', '500', '1000', 'Infinit'],
                metric: 'step')),
      ],
    );
  }

  Widget builBikingWorkoutComponent() {
    return RoundedContainer(
      backgroundColor: AppColors.instance.containerColor,
      width: MediaQuery.of(context).size.width - 32,
      margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      radius: 32.0,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
                child: Text(
              LocaleKeys.start_start_biking.tr(),
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.instance.textPrimary),
              textAlign: TextAlign.center,
            )),
            Padding(padding: EdgeInsets.only(top: 30)),
            RoundedButton(
                "start_biking",
                AppSVGAssets.start,
                () =>
                    {NavigationModule.navigateToBikingWorkoutScreen(context)}),
          ])),
    );
  }

  Widget builRollerSkatingWorkoutComponent() {
    return RoundedContainer(
      backgroundColor: AppColors.instance.containerColor,
      width: MediaQuery.of(context).size.width - 32,
      margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      radius: 32.0,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
                child: Text(
              "Are you ready for some \nroller skating tricks?",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.instance.textPrimary),
              textAlign: TextAlign.center,
            )),
            Padding(padding: EdgeInsets.only(top: 30)),
            RoundedButton(
                "start_rollerskating",
                AppSVGAssets.start,
                () => {
                      NavigationModule.navigateToRollerSkatingWorkoutScreen(
                          context)
                    }),
          ])),
    );
  }

  Widget builRunningWorkoutComponent() {
    return RoundedContainer(
      backgroundColor: AppColors.instance.containerColor,
      width: MediaQuery.of(context).size.width - 32,
      margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      radius: 32.0,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
                child: Text(
              "Are you ready for running",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.instance.textPrimary),
              textAlign: TextAlign.center,
            )),
            Padding(padding: EdgeInsets.only(top: 30)),
            RoundedButton(
                "start_running",
                AppSVGAssets.start,
                () =>
                    {NavigationModule.navigateToRunningWorkoutScreen(context)}),
          ])),
    );
  }

  void scrollTo(int index) {
    itemScrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic);
  }

  String getTimeFormatedFrom(int durationSec) {
    if (durationSec >= 3600) {
      return Duration(seconds: durationSec)
          .toString()
          .split('.')
          .first
          .substring(0, 4);
    }
    if (durationSec >= 60) {
      return Duration(seconds: durationSec)
          .toString()
          .split('.')
          .first
          .substring(2, 4);
    }
    return "-";
  }
}
