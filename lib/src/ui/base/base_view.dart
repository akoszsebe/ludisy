import 'package:flutter/material.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/ui_state.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final Color bacgroundColor;

  final UiState _uiState = locator<UiState>();

  BaseView({this.child, this.bacgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: _uiState.getBackgroundImage(), fit: BoxFit.fill)),
        child: Scaffold(backgroundColor: bacgroundColor, body: child));
  }
}
