/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:comp1640_web/constant/style.dart';
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearValues, int>> _createSampleData() {
    final data = [
      LinearValues(0, 100),
    ];

    return [
      charts.Series<LinearValues, int>(
        id: 'Comments',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primaryColor),
        domainFn: (LinearValues sales, _) => sales.day,
        measureFn: (LinearValues sales, _) => sales.value,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearValues {
  final int day;
  final int value;

  LinearValues(this.day, this.value);
}
