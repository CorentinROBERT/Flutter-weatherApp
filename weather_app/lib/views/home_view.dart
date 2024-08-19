import 'package:flutter/material.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/geoposition.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/data_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/views/add_city_view.dart';
import 'package:weather_app/views/forecast_view.dart';
import 'package:weather_app/views/my_drawer.dart';
import 'package:weather_app/views/no_data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeView> {
  GeoPosition? userPosition;
  GeoPosition? positionToCall;
  ApiResponse? response;
  List<String> cities = [];

  @override
  void initState() {
    getUserLocation();
    onUpdateCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(positionToCall?.city ?? "My weather app"),
        ),
        drawer: MyDrawer(
            myPosition: userPosition,
            cities: cities,
            onTap: onTap,
            onRemove: onRemoveCity),
        body: Column(
          children: [
            AddCityView(onAddCity: onAddCity),
            Expanded(
                child: response == null
                    ? const NoDataView()
                    : ForecastView(response!))
          ],
        ));
  }

  getUserLocation() async {
    try {
      final loc = await LocationService().getCity();
      if (loc != null) {
        setState(() {
          userPosition = loc;
          positionToCall = loc;
        });
        callApi();
      }
    } catch (e) {
      print(e);
    }
  }

  callApi() async {
    if (positionToCall == null) return;
    response = await ApiService().callApi(positionToCall!);
    setState(() {});
  }

  onTap(String string) async {
    Navigator.of(context).pop();
    removeKeyboard();
    if (string == userPosition?.city) {
      positionToCall = userPosition;
      callApi();
    } else {
      positionToCall = await LocationService().getCoordsFromCity(string);
      callApi();
    }
  }

  removeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onAddCity(String string) async {
    DataService().addCity(string).then((onSuccess) => onUpdateCities());
    removeKeyboard();
  }

  onRemoveCity(String string) async {
    await DataService()
        .removeCity(string)
        .then((onSuccess) => onUpdateCities());
  }

  onUpdateCities() async {
    cities = await DataService().getCities();
    print(cities);
    setState(() {});
  }
}
