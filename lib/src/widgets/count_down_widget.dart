import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CountdownWidget extends StatefulWidget {
  final VoidCallback callback;

  final UserState userState = locator<UserState>();

  CountdownWidget(this.callback);

  @override
  State<StatefulWidget> createState() {
    return _CountdownWidgetState();
  }
}

class _CountdownWidgetState extends StateMVC<CountdownWidget> {
  Timer _timer;
  int secTo = 0;

  @override
  void initState() {
    super.initState();
    secTo = widget.userState.getUserData().coundDownSec;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secTo--;
      });
      if (secTo <= 0) {
        _timer.cancel();
        widget.callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _timer.cancel();
          return true;
        },
        child: Container(
          color: AppColors.instance.containerColor,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                AppSVGAssets.biking,
                color: AppColors.instance.primary,
                height: 64,
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              Text(
                secTo.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 100.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.instance.primary),
              ),
            ],
          ),
        ));
  }
}
