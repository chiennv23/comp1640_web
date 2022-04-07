/// Example of a stacked area chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {this.animate});

  factory StackedAreaLineChart.withSampleData() {
    return StackedAreaLineChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(seriesList,
        animate: animate,
        /// Customize the gridlines to use a dash pattern.
        primaryMeasureAxis: const charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
                lineStyle: charts.LineStyleSpec(
                  dashPattern: [4, 4],
                ))));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearDate, DateTime>> _createSampleData() {
    final now = DateTime.now();

    var lastSunday = DateTime(now.year, now.month, now.day - now.weekday);
    final myFakeData = [
      LinearDate(lastSunday, 5),
      LinearDate(lastSunday, 25),
      LinearDate(lastSunday, 100),
      LinearDate(lastSunday, 75),
      LinearDate(lastSunday, 75),
      LinearDate(lastSunday, 75),
      LinearDate(lastSunday, 75),
    ];
    return [
      charts.Series<LinearDate, DateTime>(
        id: 'f1',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: myFakeData,
      ),
      charts.Series<LinearDate, DateTime>(
        id: 'f2',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: myFakeData,
      ),
      charts.Series<LinearDate, DateTime>(
        id: 'f3',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: myFakeData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearDate {
  final DateTime day;
  final int value;

  LinearDate(this.day, this.value);
}
