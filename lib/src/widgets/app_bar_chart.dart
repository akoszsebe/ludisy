import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stairstepsport/src/util/style/colors.dart';

class ChartItem {
  int value;
  String title;

  ChartItem(this.value, this.title);
}

class AppBarChart extends StatelessWidget {
  AppBarChart(this.dataset, this.onChangeSelected, {this.touchedIndex});
  final Color barBackgroundColor = Colors.grey[100];
  final Duration animDuration = const Duration(milliseconds: 250);
  final List<ChartItem> dataset;
  final Function(int) onChangeSelected;
  final int touchedIndex;

  @override
  Widget build(BuildContext context) {
    print("index $touchedIndex");
    return Container(
        height: 200,
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = true,
    Color barColor = AppColors.blueWithOcupacity50,
    double width = 14,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: isTouched ? AppColors.blue : barColor,
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
        handleBuiltInTouches: true,
        touchCallback: (barTouchResponse) {
          if (barTouchResponse.spot != null && barTouchResponse.touchInput is! FlPanEnd) {
            print("object");
            onChangeSelected(barTouchResponse.spot.touchedBarGroupIndex);
          }
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textBlack),
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
