import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/geoposition.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/location_service.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeView> {
  GeoPosition? userPosition;
  ApiResponse? response;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userPosition?.city ?? "My weather app"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Notre position :\nlatitude: ${userPosition?.lat}\nlongitude: ${userPosition?.long}",
              textAlign: TextAlign.center,
            ),
            Text("cnt: ${response?.cnt.toString() ?? "0"}")
          ],
        ),
      ),
    );
  }

  getUserLocation() async {
    try {
      final loc = await LocationService().getCity();
      if (loc != null) {
        setState(() {
          userPosition = loc;
        });
        response = await ApiService().callApi(userPosition!);
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }
}
