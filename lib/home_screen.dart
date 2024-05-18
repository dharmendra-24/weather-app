import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
import "package:weather_box/additional_info.dart";
import "package:weather_box/api_key.dart";
import 'package:weather_box/weather_forcast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temp=0;
  // @override
  // void initState(){
  //   super.initState();
  //   getcurrentWeather();
  // }
  Future<Map<String, dynamic>> getcurrentWeather() async {
    try {
      String cityname = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityname,uk&APPID=$OpenWeatherApiKey'),
      );

      final data = jsonDecode(res.body);
      if (int.parse(data['cod']) != 200) {
        throw 'An unexpected error occured';
      }

      return data;
      // data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        backgroundColor: Color.fromARGB(255, 39, 110, 157),
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh,
                color: Color.fromARGB(255, 229, 123, 11)),
          )
        ],
      ),
      body: FutureBuilder(
        future: getcurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('An internal error occcure'));
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final celciusTemp = currentTemp - 273.15;
          final currentsky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindspeed = data['list'][0]['wind']['speed'];
          final currenthumidity = data['list'][0]['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                Text(
                  '   London',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$celciusTemp Celcius',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                  currentsky == 'Clouds' || currentsky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 45),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentsky,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Weather Forcast',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(
                //   height: 0,
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 5; i++)
                        ForcastItem(
                          time: data['list'][i + 1]['dt_txt'].toString(),
                          icon: data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temprature:
                              (data['list'][i + 1]['main']['temp'] - 273.15)
                                  .toString(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(
                //   height: 0,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalinformationItem(
                      icon: Icons.water_drop,
                      lable: 'Humidty',
                      value: currenthumidity.toString() + '%',
                    ),
                    AdditionalinformationItem(
                      icon: Icons.air,
                      lable: 'Wind Speed',
                      value: currentWindspeed.toString() + 'm/s',
                    ),
                    AdditionalinformationItem(
                      icon: Icons.beach_access,
                      lable: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
