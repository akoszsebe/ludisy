import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/di/locator.dart';

abstract class BaseScreenState<T extends StatefulWidget,
    C extends ControllerMVC> extends StateMVC<T> {
  BaseScreenState() : super(locator<C>()) {
    con = controller;
  }
  
  C con;
}