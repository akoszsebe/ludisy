import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stairstepsport/src/data/model/day_model.dart';

class AppBarChart extends StatefulWidget {
  final List<DayModel> dataset;
  final Function(int) onChangeSelected;
  AppBarChart(this.dataset, this.onChangeSelected);

  @override
  State<StatefulWidget> createState() =>
      AppBarChartState(dataset, onChangeSelected);
}

class AppBarChartState extends State<AppBarChart> {
  AppBarChartState(this.dataset, this.onChangeSelected,
      {this.touchedIndex = 6});
  final Color barBackgroundColor = Colors.grey[100];
  final Duration animDuration = const Duration(milliseconds: 250);
  final List<DayModel> dataset;
  final Function(int) onChangeSelected;
  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("index $touchedIndex");
    return Container(
        height: 220,
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
    double width = 16,
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
      list.add(makeGroupData(i, dataset[i].totalSteps.toDouble(),
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
          setState(() {
            if (barTouchResponse.spot != null)
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
          });
          onChangeSelected(touchedIndex);
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
            return dataset[value.toInt()].date.toString();
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
