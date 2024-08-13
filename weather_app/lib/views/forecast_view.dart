import 'package:flutter/material.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/data_converter.dart';
import 'package:weather_app/model/grouped_weather.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:weather_app/views/daily_tile.dart';

class ForecastView extends StatelessWidget {
  final ApiResponse response;

  const ForecastView(this.response, {super.key});

  @override
  Widget build(BuildContext context) {
    List<GroupedWeather> byday = DataConverter().byDay(response);
    return Column(
      children: [
        CurrentWeather(forecast: response.list.first),
        Expanded(
            child: ListView.builder(
                itemBuilder: ((context, index) => DailyTile(day: byday[index])),
                itemCount: byday.length))
      ],
    );
  }
}
