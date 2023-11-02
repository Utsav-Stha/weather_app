import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/network_request/network_request.dart';
import 'package:weather_app/feature/home_page/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  getData() async {
    var a = await Future.wait([
      NetworkRequest.getLocationData(),
      NetworkRequest.getCurrentWeatherData(),
      NetworkRequest.getForecastWeatherData(),
    ]);
    print(a.runtimeType);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            NetworkRequest.getLocationData(),
            NetworkRequest.getCurrentWeatherData(),
            NetworkRequest.getForecastWeatherData(),
          ]),
          builder: (context, snapshot) {
            widget.getData();
            // print(snapshot.data.toString());
            if (snapshot.hasData) {
              /// final locationData = snapshot.data?[0];
              /// if I put it like above then the Data Type of locationData would be of type Object because the list of futures is AsyncSnapshot<List<Object?>> snapshot
              /// And the type object isn't specific enough to retrieve the data from the requested API
              /// So by putting the original return type Location? which is NetworkRequest class , I explicitally told the variable to be of particular class
              /// This make in accessing the varibale easy
              final locationData = snapshot.data?[0] as Location?;
              final currentData = snapshot.data?[1] as Current?;
              final forecastData = snapshot.data?[2] as Forecast?;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    // foregroundColor: Colors.transparent,
                    toolbarHeight: 45.0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,

                    title: Text(locationData?.name ?? ''),
                    leading: Icon(Icons.menu_rounded),
                    actions: [
                      Icon(Icons.search_rounded),
                    ],
                  ),
                  Center(
                    child: Text(
                      '${currentData?.tempC?.ceil()}°C',
                      style: TextStyle(
                        fontSize: 100.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 140,
                      width: 140,
                      child: Image.network(
                        'https:${currentData?.condition?.icon?.replaceAll('"', '')}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      currentData?.condition?.text ?? '',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Wind'),
                          SizedBox(
                            height: 8,
                          ),
                          Text('${currentData?.windKph} km/h')
                        ],
                      ),
                      Column(
                        children: [
                          Text('Humidity'),
                          SizedBox(
                            height: 8,
                          ),
                          Text('${currentData?.humidity} %')
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            //here the time value recieved from the API is splitted and only hour is taken
                            // Since the type is string, so it is converted into int
                            // Since the API used 0 to 23 format, so 1 is added
                            // Finally everything is converted into string
                            Text((int.parse((forecastData?.forecastday?[0]
                                    .hour?[DateTime.now().hour - 1].time?.split(' ').last.split(':').first)??'') +1).toString() ??
                                ''),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${forecastData?.forecastday?[0].hour?[DateTime.now().hour - 1].tempC}°C')
                          ],
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Column(
                          children: [
                            Text((int.parse((forecastData?.forecastday?[0].hour?[DateTime.now().hour].time?.split(' ').last.split(':').first)??'')+1)
                                    .toString() ??
                                ''),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${forecastData?.forecastday?[0].hour?[DateTime.now().hour].tempC}°C')
                          ],
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Column(
                          children: [
                            Text((int.parse((forecastData?.forecastday?[0].hour?[DateTime.now().hour+1].time?.split(' ').last.split(':').first)??'')+1)
                                .toString() ??
                                ''),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${forecastData?.forecastday?[0].hour?[DateTime.now().hour + 1].tempC}°C')
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Text(forecastData?.forecastday?[0]
                        //             .hour?[DateTime.now().hour + 2]
                        //             .toString() ??
                        //         ''),
                        //     SizedBox(
                        //       height: 8,
                        //     ),
                        //     Text(
                        //         '${forecastData?.forecastday?[0].hour?[DateTime.now().hour + 2].tempC}°C')
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Text(forecastData?.forecastday?[0]
                        //             .hour?[DateTime.now().hour + 3]
                        //             .toString() ??
                        //         ''),
                        //     SizedBox(
                        //       height: 8,
                        //     ),
                        //     Text(
                        //         '${forecastData?.forecastday?[0].hour?[DateTime.now().hour + 3].tempC}°C')
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Text(forecastData?.forecastday?[0]
                        //             .hour?[DateTime.now().hour + 4]
                        //             .toString() ??
                        //         ''),
                        //     SizedBox(
                        //       height: 8,
                        //     ),
                        //     Text(
                        //         '${forecastData?.forecastday?[0].hour?[DateTime.now().hour + 4].tempC}°C')
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
