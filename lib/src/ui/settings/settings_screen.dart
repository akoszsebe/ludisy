import 'package:flutter/material.dart';
import 'package:stairstepsport/src/ui/base/base_screen_state.dart';
import 'package:stairstepsport/src/ui/base/base_view.dart';
import 'package:stairstepsport/src/ui/settings/settings_controller.dart';
import 'package:stairstepsport/src/util/assets.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/widgets/quickinfobar.dart';
import 'package:stairstepsport/src/widgets/rounded_mini_button.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState
    extends BaseScreenState<SettingsScreen, SettingsController> {

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 12, top: 20, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RoundedMiniButton(
                    "back",
                    AppAssets.back,
                    () {
                      NavigationModule.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                  ),
                  QuickInfoBar(
                    con.userData.displayName != null
                        ? con.userData.displayName.split(" ")[0]
                        : "",
                    con.userData.photoUrl,
                    steps: con.stepCountValue,
                    onProfilePressed: () =>
                        NavigationModule.navigateToProfileScreen(context),
                    hostoryVisible: true,
                    onHistoryPressed: () =>
                        NavigationModule.navigateAndReplaceToHistoryScreen(
                            context),
                  ),
                ],
              )),
          Expanded(child: buildBody()),
        ]));
  }

  Widget buildBody() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(32.0))),
        height: 370,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        width: double.infinity,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
            ]));
  }
}
