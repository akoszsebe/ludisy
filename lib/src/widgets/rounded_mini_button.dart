import 'package:flutter/material.dart';
import 'package:ludisy/src/util/style/colors.dart';

class RoundedMiniButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final AssetImage asset;

  RoundedMiniButton(this.tag, this.asset, this.onPressed,
      {this.backgroundColor = Colors.white, this.iconColor = AppColors.blue});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.1,
        child: FloatingActionButton(
            heroTag: tag,
            mini: true,
            backgroundColor: backgroundColor,
            child: Image(
              height: 18,
              width: 18,
              color: iconColor,
              image: asset,
            ),
            onPressed: onPressed));
  }
}
