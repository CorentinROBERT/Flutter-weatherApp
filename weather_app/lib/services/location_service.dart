import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:weather_app/model/geoposition.dart';

class LocationService {
  Future<LocationData?> getPosition() async {
    try {
      Location location = Location();
      return location.getLocation();
    } on PlatformException catch (e) {
      print("error ${e.message}");
      return null;
    }
  }

  Future<GeoPosition?> getCity() async {
    try {
      final position = await getPosition();
      if (position == null) return null;
      final lat = position.latitude ?? 0.0;
      final long = position.longitude ?? 0.0;
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, long);
      //print(placemarks);
      final firstChoice = placemarks.first;
      final GeoPosition geoPosition =
          GeoPosition(city: firstChoice.locality ?? "", lat: lat, long: long);
      return geoPosition;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GeoPosition?> getCoordsFromCity(String city) async {
    try {
      final placemarks = await geocoding.locationFromAddress(city);
      if (placemarks.isEmpty) return null;
      return GeoPosition(
          city: city,
          lat: placemarks.first.latitude,
          long: placemarks.first.longitude);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
