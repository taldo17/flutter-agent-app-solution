import 'dart:math';

import 'package:company/networking.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'statistics.dart';

class StatisticsTab extends StatefulWidget {
  var statiscsData;

  StatisticsTab(this.statiscsData);

  @override
  _StatisticsTabState createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  List<charts.Series<Statistics, String>> barCharts;

  Icon kpiIcon;

  @override
  Widget build(BuildContext context) {
    createData();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/TalDoron.jpg'),
            radius: 50,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Duration',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            kpiIcon,
          ],
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 300.0,
            maxHeight: 300.0,
          ),
          child: charts.BarChart(
              barCharts
          ),
        ),
        GestureDetector(
          onTap: () async {
            NetworkHelper networkHelper = NetworkHelper();
            dynamic newData = await networkHelper.getData('http://10.100.102.16:8080/statistics');
            setState(() {
              widget.statiscsData = newData;
            });

          },
            child: Icon(Icons.refresh)),
      ],
    );
  }

  void createData() {
    List<Statistics> statistics = extractStatisticsData();
    setKpiIcon(statistics);

    barCharts = [
      charts.Series<Statistics, String>(
          id: 'barCharts',
          data: statistics,
          measureFn: (statistics, _) => statistics.measure,
          domainFn: (statistics, _) => statistics.domain,
          fillColorFn: (statistics, _) {
            return setFillColor(statistics);
          })
    ];
  }

  charts.Color setFillColor(Statistics statistics) {
    if (statistics.domain == 'ME') {
      return charts.MaterialPalette.blue.shadeDefault;
    }
    if (statistics.domain == 'KPI') {
      return charts.MaterialPalette.green.shadeDefault;
    }
    if (statistics.domain == 'TEAM') {
      return charts.MaterialPalette.yellow.shadeDefault;
    }
    if (statistics.domain == 'CC') {
      return charts.MaterialPalette.purple.shadeDefault;
    }
    return charts.MaterialPalette.deepOrange.shadeDefault;
  }

  void setKpiIcon(List<Statistics> statistics) {
     if(statistics[0].measure >= statistics[1].measure){
      kpiIcon = Icon(Icons.mood, color: Colors.green);
    }
    else{
      kpiIcon = Icon(Icons.mood_bad, color: Colors.red);
    }
  }

  List<Statistics> extractStatisticsData() {
    int meMeasure = widget.statiscsData['duration']['me'];
    int kpiMeasure = widget.statiscsData['duration']['kpi'];
    int teamMeasure = widget.statiscsData['duration']['team'];
    int ccMeasure = widget.statiscsData['duration']['cc'];
    List<Statistics> statistics = [
      Statistics(domain: 'ME', measure: meMeasure),
      Statistics(domain: 'KPI', measure: kpiMeasure),
      Statistics(domain: 'TEAM', measure: teamMeasure),
      Statistics(domain: 'CC', measure: ccMeasure),
    ];
    return statistics;
  }
}