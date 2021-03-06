import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'https.dart';
import 'photo.dart';
import 'httpEnfermedades.dart';
import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size),
          TitleAndPrice(
              title: "Tipo: Bougainvillea Spectabilis",
              country: "Origen: Brasil",
              price: 9),
          SizedBox(height: kDefaultPadding),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Api(),
                      ),
                    );
                  },
                  child: Text(
                    "Datos de Sensores",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApiE(),
                      ),
                    );
                  },
                  child: Text("Historial Enfermedades"),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LineChart(),
                      ),
                    );
                  },
                  child: Text("Consultar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
