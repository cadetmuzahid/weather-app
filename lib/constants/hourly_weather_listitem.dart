import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathermodel/model/weather_model.dart';

class HourlyWeatherListItem extends StatelessWidget {
  final Hour? hour;
  const HourlyWeatherListItem({super.key, this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(hour?.tempC?.round().toString()??"", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
              ),
              Text("o", style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal,
            ),
            height: 50,
              child: Image.network("https:${hour?.condition?.icon??""}")
          ),
          Text(DateFormat.j().format(DateTime.parse(hour?.time?.toString()??"",)), style: TextStyle(color: Colors.white), ),
        ],
      ),
    );
  }
}
