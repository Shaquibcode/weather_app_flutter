import 'dart:convert';

import 'package:http/http.dart';

class Services{

  String? city;
  String? temp;
  String? humidity;
  String? wind_speed;
  String? desc;
  String? main;
  String? icons;

  Services({required this.city});

Future<void>getData()async{
    try{
      Response response =  await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=a36118c26e3365650df7c4e5ed1b7c94"),);
      Map data = jsonDecode(response.body);


      Map temp_data = data['main'];
      double getTemp = temp_data['temp']-273.15;
      String getHumid = temp_data['humidity'].toString();


      List weather_data = data['weather'];
      Map weather_data_element = weather_data[0];
      String getDesc = weather_data_element['description'];
      String getMain = weather_data_element['main'];
      String getIcons = weather_data_element['icon'].toString();


      Map wind = data['wind'];
      double getAirSpeed = wind['speed']/0.27777777777778;


      temp = getTemp.toString();
      humidity = getHumid;
      wind_speed = getAirSpeed.toString();
      main = getMain;
      desc = getDesc;
      icons = getIcons;

    }catch(e){
      temp = "NA";
      humidity = "NA";
      wind_speed = "NA";
      main = "NA";
      desc = "NA";
      icons = "03n";
    }

  }

}