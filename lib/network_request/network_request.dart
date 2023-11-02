
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:weather_app/feature/home_page/weather_model.dart';

class NetworkRequest{
  static final String weather = "http://api.weatherapi.com/v1/forecast.json?key=78a88f3bc7984c1795994459233110&q=Kathmandu&days=7&aqi=no&alerts=no";
    // static final String weather = "http://api.weatherapi.com/v1/current.json?key=78a88f3bc7984c1795994459233110&q=Kathmandu&aqi=no";
    static final dio = new Dio();
    static Future<Location?> getLocationData() async{
      // Response response = await dio.get(weather);
      // print(response.statusCode);
      // print(CurrentWeatherModel.fromJson(response.data).location?.name);

      Response response = await dio.get(weather);
      print(response.statusCode);
      print(WeatherModel.fromJson(response.data).location);
      return  WeatherModel.fromJson(response.data).location;

    }
   static Future<Current?> getCurrentWeatherData() async{

     Response response;

       response = await dio.get(weather);

      return  WeatherModel.fromJson(response.data).current;
    }

    static Future<Forecast?> getForecastWeatherData() async{
      Response response;
      response = await dio.get(weather);
      return WeatherModel.fromJson(response.data).forecast;
    }

}