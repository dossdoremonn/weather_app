import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/models/weather_model.dart';
import 'package:my_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeaterPageState();
}

class _WeaterPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('411c2c72426cf4694532ab75327b52d5');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'asset_weather/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'asset_weather/cloudy.json';
      case 'rain+sun':
        return 'asset_weather/sun+rain.json';
      case 'thunder':
        return 'asset_weather/thunder.json';
      default:
        return 'asset_weather/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  //weather animations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city..."),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temparature
            Text('${_weather?.temperature.round()}°C'),
            //condition
            //temparature
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
