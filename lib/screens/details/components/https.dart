import 'dart:convert';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
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
      Plant plant = Plant(i['topic'], i["payload"], i['timestamp']);
      plants.add(plant);
    }
    print(plants);
    return plants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder(
              future: getplant(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(child: Text("No Data"));
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        DateTime fechaSet = DateTime.parse(snapshot.data[i].c);
                        String fecha = fechaSet.day.toString() +
                            '/' +
                            fechaSet.month.toString() +
                            '/' +
                            fechaSet.year.toString();
                        String hora = fechaSet.hour.toString() +
                            ':' +
                            fechaSet.minute.toString() +
                            ':' +
                            fechaSet.second.toString();
                        if (snapshot.data[i].a == 'Temp') {
                          return ListTile(
                            title: Text("Topico: Temperatura"),
                            subtitle: Text("Valor: " +
                                snapshot.data[i].b +
                                " °C"
                                    '\n'
                                    "Fecha: " +
                                fecha +
                                '\n' "Hora: " +
                                hora),
                          );
                        } else {
                          return ListTile(
                            title: Text("Topico: " + snapshot.data[i].a),
                            subtitle: Text("Valor: " +
                                snapshot.data[i].b +
                                " %"
                                    '\n'
                                    "Fecha: " +
                                fecha +
                                '\n' "Hora: " +
                                hora),
                          );
                        }
                      });
              })),
      appBar: AppBar(
        title: Text('Datos Sensores'),
      ),
    );
  }
}

class Plant {
  var a;
  var b;
  var c;

  Plant(this.a, this.b, this.c);
}
