import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:collection';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;
  Future loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/practice.json');

    data = json.decode(jsonData);
    data.sort((a, b) =>
        a.values.first["win_rate"].compareTo(b.values.first["win_rate"]));
  }

  @override
  void initState() {
    this.loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Table'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white70,
        child: DataTable(
          columns: [
            DataColumn(label: Text(' ')),
            DataColumn(label: Text(' Home ')),
            DataColumn(label: Text(' Away ')),
          ],
          rows: data.getRange(0, 4).map(
            (item) {
              final reverseItem = data[data.length - data.indexOf(item) - 1];
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text('Match ${++i}'),
                  ),
                  DataCell(
                    Text(item.values.first['name']),
                  ),
                  DataCell(
                    Text(reverseItem.values.first['name']),
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
