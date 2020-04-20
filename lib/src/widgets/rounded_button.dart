import 'package:flutter/material.dart';
import 'package:stairstepsport/src/util/style/colors.dart';

class RoundedButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final String assetName;

  RoundedButton(this.tag, this.assetName, this.onPressed,
      {this.backgroundColor = AppColors.blue,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.25,
        child: FloatingActionButton(
            heroTag: tag,
            backgroundColor: backgroundColor,
            child: Image(
              height: 18,
              width:  18,
              color: iconColor,
              image: AssetImage("lib/resources/images/$assetName"),
            ),
            onPressed: onPressed));
  }
}
