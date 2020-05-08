import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ludisy/src/util/style/colors.dart';

class RoundedMiniButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  Color backgroundColor;
  Color iconColor;
  final String assetName;

  RoundedMiniButton(this.tag, this.assetName, this.onPressed,
      {this.backgroundColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null) {
      backgroundColor = AppColors.instance.blue;
    }
    if (iconColor == null) {
      iconColor = AppColors.instance.containerColor;
    }
    return Transform.scale(
        scale: 1.1,
        child: FloatingActionButton(
            heroTag: tag,
            mini: true,
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
