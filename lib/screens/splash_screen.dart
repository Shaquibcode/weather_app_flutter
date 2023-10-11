import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/network/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? temp;
  String? hum;
  String? air_speed;
  String? main;
  String? des;
  String? icon;
  String? city = "indore";

  void start(String city) async {
    Services services = Services(city: city);
    await services.getData();

    temp = services.temp.toString();
    hum = services.humidity.toString();
    air_speed = services.wind_speed.toString();
    main = services.main;
    des = services.desc;
    icon = services.icons.toString();


    Future.delayed(
        const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, "/homeScreen", arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "airr_speed": air_speed,
        "main_value": main,
        "desc_value": des,
        "icon_value" : icon,
        "city_value": city,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;
    if(search?.isNotEmpty ?? false){
      city = search!['searchText'];
    }
    start(city!);
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  "assets/images/weather.png",
                ),
                height: 220,
                width: 220,
              ),
              SizedBox(
                height: 20
              ),
              Text(
                "Weather App",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text("My Weather App",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),),
              SizedBox(
                height: 40,
              ),
              SpinKitWave(
                size: 50,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
