/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:comp1640_web/constant/style.dart';
import 'package:flutter/material.dart';

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
      const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }
}
