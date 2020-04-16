import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Color barColor = const Color(0x807FA1F6),
    double width = 14,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: isTouched ? const Color(0xff7FA1F6) : barColor,
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
        touchCallback: (barTouchResponse) {
          if (barTouchResponse.spot != null) {
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
              color: Color(0xff010101)),
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
