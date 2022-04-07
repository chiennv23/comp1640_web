/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<YearValue, String>> _createSampleData() {
    final data = [
      YearValue((DateTime.now().year - 3).toString(), 0),
      YearValue((DateTime.now().year - 2).toString(), 0),
      YearValue((DateTime.now().year - 1).toString(), 0),
      YearValue((DateTime.now().year).toString(), 0),
    ];

    return [
      charts.Series<YearValue, String>(
        id: 'Ideas&Years',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (YearValue sales, _) => sales.year,
        measureFn: (YearValue sales, _) => sales.value,
        labelAccessorFn: (YearValue sales, _) =>
            '${sales.value.toString()} ideas',
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class YearValue {
  final String year;
  final int value;

  YearValue(this.year, this.value);
}
