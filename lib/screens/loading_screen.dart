// ignore_for_file: avoid_print

// import 'package:clima_weather_app/screens/location_screen.dart';
import 'package:clima_weather_app/screens/location_screen.dart';
import 'package:clima_weather_app/services/weather.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreenHome extends StatefulWidget {
  const LoadingScreenHome({super.key});

  @override
  State<LoadingScreenHome> createState() => _LoadingScreenHomeState();
}

class _LoadingScreenHomeState extends State<LoadingScreenHome> {
  // ?declared private can only be access  by this class

  double? latitude;
  double? longitude;
  dynamic wData;
  @override
  initState() {
    // ! here get all properties of parent init   when stateful widget build
    super.initState();
    // !adds additional  properties
    getLocationCoOrd();
  }

  Future<void> getLocationCoOrd() async {
    dynamic wData = await WeatherModel().getLocationWeather();
    print(
      "asdasd",
    );
    if (!mounted) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            recievedApiData: wData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Weather app'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '''
            Loading Weather...
            ''',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.080,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.080,
          ),
          SpinKitDoubleBounce(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.white : Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
