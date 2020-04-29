import 'package:flutter/material.dart';
import 'package:ludisy/src/util/assets.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final Color bacgroundColor;

  BaseView({this.child, this.bacgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AppAssets.background, fit: BoxFit.fill)),
        child: Scaffold(backgroundColor: bacgroundColor, body: child));
  }
}
