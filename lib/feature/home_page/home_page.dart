import 'package:flutter/material.dart';
import 'package:weather_app/feature/home_page/additional_forecast.dart';
import 'package:weather_app/feature/search_page/search_page.dart';
import 'package:weather_app/network_request/network_request.dart';
import 'package:weather_app/feature/home_page/weather_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.locationName}) : super(key: key);
  String? locationName ;

  getData() async {
    var a = await Future.wait([
      NetworkRequest.getLocationData(),
      NetworkRequest.getCurrentWeatherData(),
      NetworkRequest.getForecastWeatherData(),
    ]);
    // print(a.runtimeType);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  int count1 = 0;

  List city = ['Kathmandu', 'Pokhara', 'Mumbai', 'Delhi', 'London'];
  void changeCity(String cityName) {
    setState(() {
      widget.locationName = cityName;
      // widget.getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    print(widget.locationName);
    NetworkRequest.setCity(widget.locationName?? 'kathmandu');


    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return widget.getData();
        },
        child: SafeArea(
          child: FutureBuilder(
            future: Future.wait([
              NetworkRequest.getLocationData(),
              NetworkRequest.getCurrentWeatherData(),
              NetworkRequest.getForecastWeatherData(),
            ]),
            builder: (context, snapshot) {
              widget.getData();

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
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 8.0),
                        //   child: IconButton(
                        //     onPressed: () {
                        //       Navigator.push(context, MaterialPageRoute(
                        //         builder: (context) {
                        //           return SearchPage();
                        //         },
                        //       ));
                        //     },
                        //     icon: Icon(Icons.search_rounded),
                        //   ),
                        // ),
                        PopupMenuButton<int>(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<int>(
                                value: 0,
                                onTap: () {
                                  setState(() {
                                    widget.locationName = city[0];
                                  });
                                },
                                child: Text(city[0]),
                              ),
                              PopupMenuItem<int>(
                                onTap: () {
                                  setState(() {
                                    widget.locationName = city[1];
                                  });
                                },
                                child: Text(city[1]),
                              ),
                            ];
                          },
                        )
                      ],
                    ),
                    Center(
                      child: Text(
                        '${currentData?.tempC?.ceil()}°C',
                        style: TextStyle(
                          fontSize: 92.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(179, 229, 252, 0.4),
                        radius: 60,
                        child: Center(
                          child: Image.network(
                            'https:${currentData?.condition?.icon?.replaceAll('"', '')}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Center(
                      child: Text(
                        currentData?.condition?.text ?? '',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 120,
                      // width: 80,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            print(index);
                            if (DateTime.now().hour + count <= 23) {
                              print('before : $count');
                              var a = AdditionalForecast(
                                forecastData: forecastData,
                                count: count,
                                indexx: 0,
                              );
                              count++;
                              print('after: $count');
                              return a;
                            } else {
                              count = -DateTime.now().hour;
                              print('before : $count');
                              var a = AdditionalForecast(
                                forecastData: forecastData,
                                count: count,
                                indexx: 1,
                              );
                              count++;
                              print('after: $count');
                              return a;
                            }

                          }),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),

    );

  }
}
