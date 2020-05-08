import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ludisy/src/util/style/colors.dart';

class RoundedButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  Color backgroundColor;
  Color iconColor;
  final String assetName;
  final double scale;

  RoundedButton(this.tag, this.assetName, this.onPressed,
      {this.backgroundColor,
      this.iconColor,
      this.scale = 1.25});

  @override
  Widget build(BuildContext context) {
    if (backgroundColor==null){
      backgroundColor = AppColors.instance.primary;
    }
    if (iconColor == null){
      iconColor = AppColors.instance.containerColor;
    }
    return Transform.scale(
        scale: scale,
        child: FloatingActionButton(
            heroTag: tag,
            backgroundColor: backgroundColor,
            child: SvgPicture.asset(
              assetName,
              height: 18,
              width: 18,
              fit: BoxFit.scaleDown,
              color: iconColor,
            ),
            onPressed: onPressed));
  }
}
