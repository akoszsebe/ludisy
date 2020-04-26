import 'package:flutter/material.dart';
import 'package:ludisy/src/util/style/colors.dart';

class RoundedButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final AssetImage asset;

  RoundedButton(this.tag, this.asset, this.onPressed,
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
              image: asset,
            ),
            onPressed: onPressed));
  }
}
