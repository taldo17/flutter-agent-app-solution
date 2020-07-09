import 'package:company/statistics_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  var statiscsData;

  MainScreen(this.statiscsData);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/nice.png'),
          title: Padding(
            padding: const EdgeInsets.only(left: 95.0),
            child: Text('MY-APP'),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'ME',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'CHALLENGE',
                icon: Icon(Icons.question_answer),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Card(
                color: Colors.grey.shade200,
                child: StatisticsTab(widget.statiscsData),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Card(
                color: Colors.grey.shade200,
                child: Center(
                  child: Text('CHALLENGE-TAB'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
