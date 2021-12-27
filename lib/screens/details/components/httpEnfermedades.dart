import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiE extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<ApiE> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    if (counter == 0) {
      counter = 1;
    }
    counter++;
    var response = await get(Uri.parse(
        "http://34.72.145.97/dataMqtt/detail_image/" + counter.toString()));

    var imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: Text('Historial de Enfermedades'),
        ),
      ),
    );
  }
}

class ImageModel {
  int id;
  String url;
  String title;

  ImageModel(this.id, this.url, this.title);

  // Named constructor
  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    //id = parsedJson['accuracy'];
    url = parsedJson['image'];
    title = parsedJson['disease_name'].toString();
  }
}

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  Widget build(context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      },
    );
  }
}

Widget buildImage(ImageModel image) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black54,
      ),
    ),
    padding: EdgeInsets.all(20.0),
    margin: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Image.network(image.url, fit: BoxFit.cover),
        ),
        Text(image.title),
      ],
    ),
  );
}
