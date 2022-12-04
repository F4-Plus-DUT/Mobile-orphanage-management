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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Organizing Management Statistics",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Card(
              margin: EdgeInsets.all(10),
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
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              )
                            ],
                            primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0),
                                labelStyle: TextStyle(fontSize: 14)),
                            primaryYAxis: NumericAxis(
                                majorGridLines: MajorGridLines(width: 0),
                                numberFormat: NumberFormat.compact()),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Annual Cost Statistic",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: FutureBuilder<DonateStatistic>(
                future: StatisticNetWork.GetDonateStatistic(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data;

                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                            color: Colors.grey),
                        child: Text(
                          "Summary",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                      ),
                      StatisticDonate(
                        label: "Total donate",
                        amount: data!.total_donate,
                      ),
                      StatisticDonate(
                        label: "Total expense",
                        amount: data.total_expense,
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class StatisticDonate extends StatelessWidget {
  final String label;
  final int amount;
  const StatisticDonate({
    Key? key,
    required this.label,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Text(
            label + ": ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          Text(
            amount.toString(),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
