import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/ui/splash/splash_controller.dart';
import 'package:stairstepsport/src/util/assets.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/widgets/loader.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(locator<SplashController>()) {
    con = controller;
  }
  SplashController con;

  @override
  void initState() {
    super.initState();
    con.checkLogin((logenIn) async {
      await precacheImages();
      if (logenIn) {
        NavigationModule.navigateToStartScreen(context);
      } else {
        NavigationModule.navigateToLoginScreen(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 24),
        child: Scaffold(
            backgroundColor: Colors.white, body: Center(child: buildLoader())));
  }

  Widget buildLoader() {
    return Loader();
  }

  Future<void> precacheImages() async {
    await precacheImage(AppAssets.background, context);
  }
}
