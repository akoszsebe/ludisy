import 'package:flutter/material.dart';
import 'package:stairstepsport/src/util/assets.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final Color bacgroundColor;

  BaseView({this.child, this.bacgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AppAssets.background, fit: BoxFit.fill)),
        child: Scaffold(backgroundColor: bacgroundColor, body: child));
  }
}
