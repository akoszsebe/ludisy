import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ludisy/src/util/style/colors.dart';

class AppBuilder extends StatefulWidget {
  final Widget widget;

  const AppBuilder({Key key, this.widget}) : super(key: key);

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.instance.primaryDark,
    ));
    return widget.widget;
  }

  void rebuild() {
    setState(() {});
  }
}
