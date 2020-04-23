import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stairstepsport/src/ui/base/base_screen_state.dart';
import 'package:stairstepsport/src/ui/splash/splash_controller.dart';
import 'package:stairstepsport/src/util/assets.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';
import 'package:stairstepsport/src/util/style/colors.dart';
import 'package:stairstepsport/src/widgets/loader.dart';

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
    return Container(
        margin: EdgeInsets.only(top: 24),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
              SizedBox(
                height: 56,
              ),
              Text(
                "Stair sport",
                style: GoogleFonts.montserrat(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue),
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
    await precacheImage(AppAssets.background, context);
  }
}
