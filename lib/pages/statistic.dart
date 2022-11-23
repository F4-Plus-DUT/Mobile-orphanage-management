import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orphanage_management_system/helper/string_helper.dart';
import 'package:orphanage_management_system/network/statistic.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/statistic.dart';

class StatisticPage extends StatefulWidget {
  @override
  State<StatisticPage> createState() => _StatisticState();
}

class _StatisticState extends State<StatisticPage> {
  late int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistic Page'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Card(
        child: FutureBuilder<List<Statistic>>(
            future: StatisticNetWork.GetStatistic(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: SfCartesianChart(
                      series: <ChartSeries<Statistic, dynamic>>[
                        BarSeries<Statistic, dynamic>(
                          dataSource: data,
                          // Renders the track
                          isTrackVisible: true,
                          xValueMapper: (Statistic data, _) =>
                              data.key.capitalize(),
                          yValueMapper: (Statistic data, _) => data.value,
                          name: 'Statistic',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ],
                      primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          numberFormat: NumberFormat.compact()),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget buildIndicator({
    required Color color,
    required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}
