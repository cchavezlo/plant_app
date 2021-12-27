import 'dart:convert';
//import 'dart:html';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_image/flutter_image.dart';
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
      counter = 0;
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
  fetchImage_(String url_) async {
    var imageId = await ImageDownloader.downloadImage(url_);
    // Below is a method of obtaining saved image information.
    String fileName = await ImageDownloader.findName(imageId);
    String path = await ImageDownloader.findPath(imageId);
    return path;
  }

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
  fetchImage_(String url_) async {
    var imageId = await ImageDownloader.downloadImage(url_);
    // Below is a method of obtaining saved image information.
    String fileName = await ImageDownloader.findName(imageId);
    final String path = await ImageDownloader.findPath(imageId);
    return path;
  }

  // String path_ = fetchImage_(image.url).toString();
  var avatar = new Image(
    image: new NetworkImageWithRetry(image.url),
  );
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
          //child:  Image.network(image.url, fit: BoxFit.cover),
          //child: ImageList.fet(),
          child: Image.asset("images/bottom_img_1.jpeg"),
          //child: Image.file(File(path_), ),
          //child: avatar,
        ),
        Text(image.title),
      ],
    ),
  );
}
