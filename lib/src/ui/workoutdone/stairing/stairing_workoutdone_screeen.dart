import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/generated/locale_keys.g.dart';
import 'package:ludisy/src/ui/workoutdone/stairing/stairing_workoutdone_controller.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';

class StairingWorkoutDoneScreen extends StatefulWidget {
  StairingWorkoutDoneScreen({Key key}) : super(key: key);
  @override
  _WorkOutDoneScreenState createState() => _WorkOutDoneScreenState();
}

class _WorkOutDoneScreenState extends BaseScreenState<StairingWorkoutDoneScreen,
    StairingWorkoutDoneController> {
  _WorkOutDoneScreenState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        bacgroundColor: AppColors.instance.primaryWithOcupacity50,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 12, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RoundedMiniButton(
                      "back",
                      AppSVGAssets.back,
                      () {
                        NavigationModule.pop(context);
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            ContainerWithActionAndLeading(
                leading: Container(
                  decoration: BoxDecoration(
                    color: AppColors.instance.containerColor,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  width: 64.0,
                  height: 64.0,
                  child: SvgPicture.asset(
                    AppSVGAssets.stairing,
                    color: AppColors.instance.iconPrimary,
                    height: 17,
                    width: 17,
                  ),
                ),
                height: 400,
                margin: EdgeInsets.only(bottom: 24),
                child: RoundedContainer(
                  height: 400,
                  backgroundColor: AppColors.instance.containerColor,
                  radius: 32.0,
                  margin:
                      EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
                ),
                action: RoundedButton(
                  "done",
                  AppSVGAssets.done,
                  () => NavigationModule.pop(context),
                )),
          ],
        ));
  }
}
