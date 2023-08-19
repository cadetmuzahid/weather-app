import 'package:flutter/material.dart';
import 'package:weathermodel/constants/hourly_weather_listitem.dart';
import 'package:weathermodel/model/weather_model.dart';
import 'package:weathermodel/service/api_service.dart';
import 'package:weathermodel/ui/components/todays_weather.dart';

import 'components/future_forecast_listItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();

  final _textFieldController = TextEditingController();
  String secrchText = "auto:ip";


  _showTextInputDialog(BuildContext context)async{
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Search Location"),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          hintText: "Search by city, zip, ip, lat, lang"
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: (){Navigator.pop(context);},
            child: Text("Cancle")
        ),
        ElevatedButton(
            onPressed: (){
              if(_textFieldController.text.isEmpty){
                return;
              }
              Navigator.pop(context, _textFieldController.text);
              },
            child: Text("OK")
        ),
      ],
    );
  },);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Flutter Weather App"),
        actions: [
          IconButton(onPressed: ()async{
            _textFieldController.clear();
           String text = await _showTextInputDialog(context);
           setState(() {
             secrchText = text;
           });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            secrchText = "auto:ip";
            setState(() {

            });

          }, icon: Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TodaysWeather(
                        weatherModel: weatherModel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Weather by Hours",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(itemBuilder: (context, index) {
                          Hour? hour= weatherModel?.forecast?.forecastday?[0].hour?[index];
                          return  HourlyWeatherListItem(
                            hour: hour,
                          );
                        },itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Next 7 days weather",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                          Forecastday? forecastday = weatherModel?.forecast?.forecastday?[index];
                          return FutureForecastListItem(forecastday: forecastday,);


                        },itemCount: weatherModel?.forecast?.forecastday?.length,),
                      )


                    ],
                  ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Eror has occured"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiService.getWeatherData(secrchText),
        ),
      ),
    );
  }
}
