import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weathermodel/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodaysWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current){
  if(current?.isDay==1){

    if(current?.condition?.text=="Sunny"){
      return WeatherType.sunny;
    }else if(current?.condition?.text=="Over Cast"){
      return WeatherType.overcast;
    }else if(current?.condition?.text=="Partly Cloudy"){
      return WeatherType.cloudy;
    }else if(current?.condition?.text=="Cloudy"){
      return WeatherType.cloudy;
    }else if(current!.condition!.text!.contains("Thunder")){
      return WeatherType.thunder;
    }else if(current!.condition!.text!.contains("Rain")){
      return WeatherType.heavyRainy;
    }else if(current!.condition!.text!.contains("Showers")){
      return WeatherType.middleSnow;
    }else if(current!.condition!.text!.contains("Clear")){
      return WeatherType.sunny;
    }



  }else{

    if(current?.condition?.text=="Sunny"){
      return WeatherType.sunny;
    }else if(current?.condition?.text=="Over Cast"){
      return WeatherType.overcast;
    }else if(current?.condition?.text=="Partly Cloudy"){
      return WeatherType.cloudyNight;
    }else if(current?.condition?.text=="Cloudy"){
      return WeatherType.cloudyNight;
    }else if(current!.condition!.text!.contains("Thunder")){
      return WeatherType.thunder;
    }else if(current!.condition!.text!.contains("Rain")){
      return WeatherType.heavyRainy;
    }else if(current!.condition!.text!.contains("Showers")){
      return WeatherType.middleSnow;
    }else if(current!.condition!.text!.contains("Clear")){
      return WeatherType.sunnyNight;
    }


  }




    return WeatherType.thunder;
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
            weatherType: getWeatherType(weatherModel?.current),
            width: MediaQuery.of(context).size.width,
            height: 345),
        SizedBox(
          width: double.infinity,
          height: 345,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(weatherModel?.location?.name ?? "",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.parse(
                            weatherModel?.current?.lastUpdated.toString() ??
                                "")),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                      ),
                      child: Image.network(
                          "https:${weatherModel?.current?.condition?.icon ?? ""}")),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                                weatherModel?.current?.tempC
                                        ?.round()
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80,
                                )),
                          ),
                          Text(
                            "o",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Feels Like",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              weatherModel?.current?.feelslikeC?.round()?.toString()??"",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Humidity",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity}%",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
