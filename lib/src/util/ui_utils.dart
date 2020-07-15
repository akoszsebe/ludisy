import 'package:fl_chart/fl_chart.dart';
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

class AppChart {
  static LineChartBarData buildLineChartBarData(spots, color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: [
        color,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [color.withOpacity(0.3), color.withOpacity(0.0)],
        gradientColorStops: [0.4, 1.0],
        gradientFrom: const Offset(0, 0),
        gradientTo: const Offset(0, 1),
      ),
    );
  }

  static LineChartData lineChartData(lineBarsData) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 1,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      lineBarsData: lineBarsData,
    );
  }
}
