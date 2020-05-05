import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludisy/src/util/assets.dart';

class WorkoutQuickInfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
        child: SvgPicture.asset(
          AppSVGAssets.workoutInfo,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[Text("32"), Text("min")],
          ),
          Column(
            children: <Widget>[
              SvgPicture.asset(
                AppSVGAssets.stairing,
              ),
              Text("10"),
              Text("km")
            ],
          ),
          Column(
            children: <Widget>[Text("7.5"), Text("km")],
          ),
        ],
      )
    ]);
  }
}
