import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cityName = ["Uttar Pradesh", "Mumbai", "Delhi", "London", "Paris"];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];
    Map? info = ModalRoute.of(context)!.settings.arguments as Map?;
    String temprature = ((info!["temp_value"]).toString());
    String icon = info!['icon_value'];
    String getCity = info!['city_value'];
    String hum = info['hum_value'];
    String air = ((info['airr_speed']).toString()).substring(0,4);
    String desc = info['desc_value'];
    if(temprature == "NA"){
      print("NA");
    }else{
      temprature = ((info!["temp_value"]).toString()).substring(0,4);
      air = ((info['airr_speed']).toString()).substring(0,4);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue.shade800,
                    Colors.blue.shade300,
                  ],
              ),
            ),
            child: Column(
              children: [
                //search box
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == ""){
                            print("blank");
                          }else{
                            Navigator.pushReplacementNamed(context, "/splash", arguments: {
                              "searchText" : searchController.text,
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: const Icon(Icons.search, color: Colors.blueAccent,),
                        ),
                      ),
                     Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Cities Like $city!",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child:  Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png", height: 45, width: 45,),
                            const SizedBox(width: 20,),
                           Column(
                              children: [
                                Text(desc, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text(getCity, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/temp.png", height: 70, width: 70,),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(temprature, style: const TextStyle(fontSize: 90),),
                                const Text("C", style: TextStyle(fontSize: 30),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(Icons.air),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              air, style: const TextStyle(fontSize: 40),
                            ),
                            const Text(
                                "Km/Hr"
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child:  Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(Icons.water_drop),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              hum, style: const TextStyle(fontSize: 40),
                            ),
                            const Text(
                                "Percent"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("@Copyright 2023"),
                      Text("This Data is Extracted From OpenWeatherAPI"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
