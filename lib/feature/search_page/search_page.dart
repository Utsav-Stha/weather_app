import 'package:flutter/material.dart';
import 'package:weather_app/feature/home_page/home_page.dart';
import 'package:weather_app/network_request/network_request.dart';

class SearchPage extends StatelessWidget {
   SearchPage({Key? key}) : super(key: key);
 List city = ['Kathmandu','Pokhara','Mumbai','Delhi','London'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: city.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){

                  // Navigator.pop(context);
                },
                child: Card(
                  child: Text(city[index]),
                ),
              );
            },)
      ),
    );
  }
}
