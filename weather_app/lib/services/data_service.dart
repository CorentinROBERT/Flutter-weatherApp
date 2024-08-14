import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  final key = "cities";

  Future<List<String>> getCities() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final list = preferences.getStringList(key);
    return list ?? [];
  }

  Future<bool> addCity(String string) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var list = preferences.getStringList(key) ?? [];
    list.add(string);
    return preferences.setStringList(key, list);
  }

  Future<bool> removeCity(String string) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var list = preferences.getStringList(key) ?? [];
    list.remove(string);
    return preferences.setStringList(key, list);
  }
}
