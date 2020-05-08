import 'package:flutter/material.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_controller.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';

class BikingWorkoutScreen extends StatefulWidget {
  BikingWorkoutScreen({Key key}) : super(key: key);
  @override
  _BikingWorkoutScreenState createState() => _BikingWorkoutScreenState();
}

class _BikingWorkoutScreenState
    extends BaseScreenState<BikingWorkoutScreen, BikingWorkoutController> {
  _BikingWorkoutScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: BaseView(
            bacgroundColor: AppColors.instance.blueWithOcupacity50,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 40),
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
              ],
            )));
  }
}
