import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/splash/splash_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/loader.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState
    extends BaseScreenState<SplashScreen, SplashController> {
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Scaffold(
            backgroundColor: AppColors.instance.containerColor,
            body: Column(children: <Widget>[
              SizedBox(
                height: 56,
              ),
              Text(
                "Ludisy",
                style: GoogleFonts.montserrat(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.instance.primary),
              ),
              SizedBox(
                height: 40,
              ),
              Image(
                height: 170,
                width: 170,
                image: AppAssets.splash_icon,
              ),
              SizedBox(
                height: 200,
              ),
              buildLoader()
            ])));
  }

  Widget buildLoader() {
    return Loader();
  }

  Future<void> precacheImages() async {
    await precacheImage(AppAssets.background_stair, context);
    await precacheImage(AppAssets.background_bike, context);
  }
}
