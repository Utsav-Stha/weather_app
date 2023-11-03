import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weather_app/feature/home_page/weather_model.dart';

class NetworkRequest {
  static final String weather =
      "http://api.weatherapi.com/v1/forecast.json?key=78a88f3bc7984c1795994459233110&q=Kathmandu&days=7&aqi=no&alerts=no";
  static final dio = new Dio();

  static Future<Location?> getLocationData() async {
    Response response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).location;
  }

  static Future<Current?> getCurrentWeatherData() async {
    Response response;
    response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).current;
  }

  static Future<Forecast?> getForecastWeatherData() async {
    Response response;
    response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).forecast;
  }
}
