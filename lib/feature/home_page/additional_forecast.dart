import 'package:flutter/material.dart';
import 'package:weather_app/feature/home_page/weather_model.dart';

class AdditionalForecast extends StatelessWidget {
  const AdditionalForecast(
      {Key? key,
      required this.forecastData,
      required this.count,
      required this.indexx})
      : super(key: key);
  final Forecast? forecastData;
  final int count;
  final int indexx;
  @override
  Widget build(BuildContext context) {
    print(indexx);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          child: Column(
            children: [
              //here the time value recieved from the API is splitted and only hour is taken
              // Since the type is string, so it is converted into int
              // Since the API used 0 to 23 format, so 1 is added
              // Finally everything is converted into string
              // Text((forecastData?.forecastday?[indexx].hour?[DateTime.now().hour].time) ?? ''),

              Text((int.parse((forecastData?.forecastday?[indexx]
                  .hour?[DateTime.now().hour + count].time
                  )??
                  '') )
                  .toString() ??
                  ''),
              SizedBox(
                height: 4,
              ),
              Image.network(
                  'https:${forecastData?.forecastday?[indexx].hour?[DateTime.now().hour+count].condition?.icon}',
              width: 50,
                height: 30,
              ),
              Text(
                  '${forecastData?.forecastday?[indexx].hour?[DateTime.now().hour + count].tempC?.ceil()}°C')
            ],
          ),
        ),
      ),
    );
  }
}
