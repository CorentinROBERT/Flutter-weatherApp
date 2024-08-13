import 'package:flutter/material.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/geoposition.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/views/forecast_view.dart';
import 'package:weather_app/views/no_data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
        body: response == null ? const NoDataView() : ForecastView(response!));
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
