import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';

class CountdownWidget extends StatefulWidget {
  final VoidCallback callback;

  CountdownWidget(this.callback);

  @override
  State<StatefulWidget> createState() {
    return _CountdownWidgetState();
  }
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer _timer;
  int secTo = 5;

  @override
  void initState() {
    super.initState();
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
    return Container(
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
    );
  }
}
