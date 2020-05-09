import 'package:flutter/material.dart';

class ContainerWithAction extends StatelessWidget {
  final Widget child;
  final Widget action;
  final double height;
  final EdgeInsetsGeometry margin;

  const ContainerWithAction(
      {Key key, this.action, this.child, this.margin, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: margin,
        height: height,
        child: Stack(children: <Widget>[
          child,
          Align(alignment: Alignment.bottomCenter, child: action)
        ]));
  }
}

class ContainerWithActionAndLeading extends StatelessWidget {
  final Widget child;
  final Widget action;
  final Widget leading;
  final double height;
  final EdgeInsetsGeometry margin;

  const ContainerWithActionAndLeading(
      {Key key,
      this.action,
      this.child,
      this.margin,
      this.height,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: margin,
        height: height,
        child: Stack(children: <Widget>[
          child,
          Align(alignment: Alignment.topCenter, child: leading),
          Align(alignment: Alignment.bottomCenter, child: action)
        ]));
  }
}
