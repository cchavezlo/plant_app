import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatelessWidget {
  getplant() async {
    var response =
        await http.get(Uri.parse("http://34.72.145.97/dataMqtt/register_data"));
    //    ,
    //  headers: {'Accept': 'application/json'}
    // Uri.https("http://34.72.145.97/dataMqtt/register_data"),
    // headers: {'Content-type': 'application/json'},
//    );
    var jsondata = jsonDecode(response.body);

    List<Plant> plants = [];

    for (var i in jsondata) {
      Plant plant = Plant(i['topic'], i["payload"], i['timestamp'], i['id']);
      plants.add(plant);
    }
    print(plants);
    return plants;
  }

  // Defining the data
  final data = [
    new SalesData(0, 13),
    new SalesData(1, 17),
    new SalesData(2, 16),
    new SalesData(3, 18),
    new SalesData(4, 19),
    new SalesData(5, 23),
    new SalesData(6, 26),
    new SalesData(7, 19),
    new SalesData(8, 25),
    new SalesData(9, 27),
    new SalesData(10, 3),
    new SalesData(11, 37),
    new SalesData(12, 21),
    new SalesData(13, 21),
  ];

  _getSeriesData_() {
    List<charts.Series<Plant, int>> series = [
      charts.Series(
          id: "d",
          data: getplant(),
          domainFn: (Plant series, _) => series.b,
          measureFn: (Plant series, _) => series.c,
          colorFn: (Plant series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  _getSeriesData() {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grafica'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 550,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Monitoreo de Temperatura",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: new charts.LineChart(
                        _getSeriesData(),
                        animate: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

class Plant {
  var a;
  var b;
  var c;
  var d;

  Plant(this.a, this.b, this.c, this.d);
}
