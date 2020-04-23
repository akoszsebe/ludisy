import 'package:flutter/material.dart';
import 'package:stairstepsport/src/util/assets.dart';

class BaseView extends StatelessWidget {
  final Widget child;

  BaseView({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AppAssets.background, fit: BoxFit.fill)),
        child: Scaffold(backgroundColor: Colors.transparent, body: child));
  }
}
