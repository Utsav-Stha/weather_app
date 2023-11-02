import 'package:flutter/material.dart';
import 'package:weather_app/network_request/network_request.dart';

import 'feature/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey
        )
      ),
      home: HomePage(),
    );
  }
}




