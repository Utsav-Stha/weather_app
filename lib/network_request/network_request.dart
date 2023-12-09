import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weather_app/feature/home_page/weather_model.dart';

class NetworkRequest {
  static String? cityName;
  static final String apiKey = "78a88f3bc7984c1795994459233110";
  static final String baseUrl = "http://api.weatherapi.com/v1/forecast.json";
  static final Dio dio = Dio();


  static String get weather {
    return "$baseUrl?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no";
  }

  static void setCity(String name) {
    cityName = name;
    print(cityName);
  }

  static Future<Location?> getLocationData() async {
    print(cityName);
    Response response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).location;
  }

  static Future<Current?> getCurrentWeatherData() async {
    Response response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).current;
  }

  static Future<Forecast?> getForecastWeatherData() async {
    Response response = await dio.get(weather);
    return WeatherModel.fromJson(response.data).forecast;
  }
}
