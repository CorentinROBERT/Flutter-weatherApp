import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/geoposition.dart';
import 'package:weather_app/services/api_key_service.dart';

class ApiService {
  String baseUrl = "https://api.openweathermap.org/data/2.5/forecast";
  String lat = "lat=";
  String lon = "lon=";
  String appId = "appid=";
  String lang = "lang=fr";
  String units = "units=metric";

  String prepareQuery(GeoPosition geoposition) {
    final geoLat = geoposition.lat;
    final geoLon = geoposition.long;
    return "$baseUrl?$lat$geoLat&$lon$geoLon&$units&$lang&$appId$api";
  }

  Future<ApiResponse?> callApi(GeoPosition position) async {
    try {
      final queryString = prepareQuery(position);
      final call = await get(Uri.parse(queryString));
      Map<String, dynamic> map = json.decode(call.body);
      print(map);
      return ApiResponse.fromJson(map);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
