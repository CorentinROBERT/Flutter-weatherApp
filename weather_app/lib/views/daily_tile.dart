import 'package:flutter/material.dart';
import 'package:weather_app/model/data_converter.dart';
import 'package:weather_app/model/grouped_weather.dart';

class DailyTile extends StatelessWidget {
  GroupedWeather day;

  DailyTile({required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      color: Theme.of(context).primaryColorLight,
      child: ListTile(
        trailing: Image.network(DataConverter().fromIcon(day.icon)),
        leading: Text(day.day),
        title: Text(day.description),
        subtitle: Text(day.minAndMax()),
      ),
    );
  }
}
