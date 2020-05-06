import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutQuickInfoBar extends StatelessWidget {
  final String metric;
  final String timeMetric;
  final String time;
  final String value;
  final String avgValue;
  final String assetName;

  WorkoutQuickInfoBar(
    this.time,
    this.value,
    this.avgValue,
    this.metric,
    this.timeMetric,
    this.assetName
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        child: Stack(children: <Widget>[
          Center(
            child: SvgPicture.asset(
              AppSVGAssets.workoutInfo,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          timeMetric,
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              assetName,
                              height: 20,
                              color: Colors.white,
                            )),
                        Text(
                          value,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          metric,
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "avg. $metric",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ]));
  }
}
