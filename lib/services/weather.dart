import 'package:clima_weather_app/services/location_service.dart';
import 'package:clima_weather_app/services/network_helper.dart';
import 'package:clima_weather_app/utils/constants.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    // !class obj created for locaion service
    MyLocationService gettingGpsLoc = MyLocationService();
    // !waiting future function response for ticket
    await gettingGpsLoc.getCurrentLocationService();

    // !class obj for data services i.e api
    NetworkHelper netHelperFordata = NetworkHelper(
        url:
            '$apiUrl?lat=${gettingGpsLoc.currentLatitude}&lon=${gettingGpsLoc.currentLongitude}&appid=$apiKey');
    // !wait for data to complete
    dynamic weatherData = await netHelperFordata.getDataFromAPi();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
