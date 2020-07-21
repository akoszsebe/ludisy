import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';

class WorkoutQuickInfoBar extends StatelessWidget {
  final String metric;
  final String timeMetric;
  final String time;
  final String value;
  final String avgValue;
  final String assetName;

  WorkoutQuickInfoBar(this.time, this.value, this.avgValue, this.metric,
      this.timeMetric, this.assetName);

  @override
  Widget build(BuildContext context) {
    return ContainerWithActionAndLeading(
        leading: Container(
            decoration: BoxDecoration(
              color: AppColors.instance.containerColor,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            width: 64.0,
            height: 64.0,
            child: SvgPicture.asset(
              assetName,
              height: 17,
              width: 17,
              fit: BoxFit.scaleDown,
              color: AppColors.instance.primary,
            )),
        child: RoundedContainer(
            backgroundColor: AppColors.instance.containerColor,
            width: MediaQuery.of(context).size.width - 32,
            margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            padding: EdgeInsets.all(20),
            radius: 32.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      Text(
                        time,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.instance.primary),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        timeMetric,
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      Text(
                        value,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.instance.primary),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        metric,
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      Text(
                        avgValue,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.instance.primary),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "avg. $metric",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
