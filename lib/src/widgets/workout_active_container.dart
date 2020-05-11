import 'package:flutter/material.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/ui_utils.dart';

class WorkoutActiveContainer extends StatelessWidget {
  final Widget leftChild;
  final Widget centerChild;
  final Widget rightChild;
  final double centerDiameter;

  const WorkoutActiveContainer(
      {Key key,
      @required this.leftChild,
      @required this.centerChild,
      @required this.rightChild,
      this.centerDiameter = 96})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        RoundedContainer(
          backgroundColor: AppColors.instance.containerColor,
          radius: 32.0,
          height: 48,
          width: 240,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[leftChild, rightChild],
          ),
        ),
        RoundedContainer(
          backgroundColor: AppColors.instance.containerColor,
          radius: centerDiameter / 2,
          height: centerDiameter,
          width: centerDiameter,
          child: centerChild,
        ),
      ],
    );
  }
}
