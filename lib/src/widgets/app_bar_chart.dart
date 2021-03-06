import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/util/style/colors.dart';

class ChartItem {
  int value;
  String title;

  ChartItem(this.value, this.title);
}

class AppBarChart extends StatelessWidget {
  AppBarChart(this.dataset, {this.touchedIndex});
  final Color barBackgroundColor = Colors.grey[100];
  final Duration animDuration = const Duration(milliseconds: 250);
  final List<ChartItem> dataset;
  final int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 13, right: 13),
        height: 200,
        width: 294,
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = true,
    Color barColor,
    double width = 16,
    List<int> showTooltips = const [],
  }) {
    if (barColor == null) {
      barColor = AppColors.instance.primaryWithOcupacity50;
    }
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: isTouched ? AppColors.instance.primary : barColor,
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> list = List();
    for (var i = 0; i < dataset.length; i++) {
      list.add(makeGroupData(i, dataset[i].value.toDouble(),
          isTouched: i == touchedIndex));
    }
    return list;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem("", TextStyle(color: Colors.yellow));
            }),
        handleBuiltInTouches: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.textPrimary),
          margin: 16,
          getTitles: (double value) {
            return dataset[value.toInt()].title;
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
