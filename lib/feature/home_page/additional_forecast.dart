import 'package:flutter/material.dart';

class AdditionalForecast extends StatelessWidget {
  const AdditionalForecast({Key? key, required this.forecastData}) : super(key: key);
  final forecastData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(

        child: Padding(
          padding: const EdgeInsets.fromLTRB(14.0,12.0,14.0,12.0),
          child: Column(
            children: [
              //here the time value recieved from the API is splitted and only hour is taken
              // Since the type is string, so it is converted into int
              // Since the API used 0 to 23 format, so 1 is added
              // Finally everything is converted into string
              Text((int.parse((forecastData
                  ?.forecastday?[0]
                  .hour?[
              DateTime.now().hour - 1]
                  .time
                  ?.split(' ')
                  .last
                  .split(':')
                  .first) ??
                  '') +
                  1)
                  .toString() ??
                  ''),
              SizedBox(
                height: 8,
              ),
              Text(
                  '${forecastData?.forecastday?[0].hour?[DateTime.now().hour - 1].tempC}°C')
            ],
          ),
        ),
      ),
    );
  }
}
