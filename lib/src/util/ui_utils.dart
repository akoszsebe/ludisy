import 'package:flutter/material.dart';

class AppContainerBoxShadow extends BoxShadow {
  AppContainerBoxShadow()
      : super(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 3,
          offset: Offset(0, 0),
        );
}

class RoundedContainer extends Container {
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final Widget child;
  final double radius;

  RoundedContainer(
      {this.height,
      this.width,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.child,
      this.radius})
      : super(
            child: child,
            height: height,
            width: width,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              boxShadow: [AppContainerBoxShadow()],
            ));
}
