import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepData extends StatefulWidget {
  const StepData({super.key});

  @override
  State<StepData> createState() => _StepDataState();
}

class _StepDataState extends State<StepData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BarChart(
        BarChartData(
          maxY: 10,
          minY: 0,
          
        )
      ),
    );
  }
}