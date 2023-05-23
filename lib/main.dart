import 'package:flutter/material.dart';
import 'package:clima_weather_app/screens/loading_screen.dart';

void main() {
  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima Weather App',
      theme: ThemeData.dark(),
      home: const LoadingScreenHome(),
    );
  }
}
