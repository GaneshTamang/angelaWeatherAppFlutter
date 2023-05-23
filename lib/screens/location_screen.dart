// ignore_for_file: avoid_print

import 'package:clima_weather_app/services/weather.dart';
import 'package:clima_weather_app/utils/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.recievedApiData, super.key});

  final dynamic recievedApiData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? city;
  double? tempInKelvin;
  double? tempInCelcius;
  int? weatherCondition;
  String? weatherConditionIcon;
  String? messageAccordingToWeather;

  @override
  void initState() {
    super.initState();
    dynamic mydata = widget.recievedApiData;
    print('recieved data:\n $mydata');
    updateUI(mydata);
  }

  updateUI(dynamic recievedData) {
    setState(() {
      city = recievedData['name'];
      tempInKelvin = recievedData['main']['temp'];
      weatherCondition = recievedData['weather'][0]['id'];
      tempInCelcius = convertValueInDegreeCelcius(tempInKelvin!);
      weatherConditionIcon = weather.getWeatherIcon(weatherCondition!);
      // !get ceiling value of double for  changing into int to get message for  condition check with temperature
      messageAccordingToWeather =
          weather.getMessage(tempInCelcius!.toInt().ceil());
    });
  }

  /// here open weather map Api is not reponnding in clecius with url+&units=metric
  ///so making function [convertValueInDegreeCelcius] for getting data in celcius
  double convertValueInDegreeCelcius(double tempInK) {
    double inCelcius = tempInK - 273.15;
    return inCelcius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      debugPrint('getting location id and data');
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint('checking city');
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${tempInCelcius!.toStringAsFixed(2)} °C ',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherConditionIcon',
                      // '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$messageAccordingToWeather in $city ',
                  // "It's 🍦 time in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
