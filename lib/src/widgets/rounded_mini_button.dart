import 'package:flutter/material.dart';

class RoundedMiniButton extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final String assetName;

  RoundedMiniButton(this.tag, this.assetName, this.onPressed,
      {this.backgroundColor = Colors.white,
      this.iconColor = const Color(0xff7FA1F6)});

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
              image: AssetImage("lib/resources/images/$assetName"),
            ),
            onPressed: onPressed));
  }
}
