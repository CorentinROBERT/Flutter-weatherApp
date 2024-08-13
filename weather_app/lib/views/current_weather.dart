import 'package:flutter/material.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/data_converter.dart';

class CurrentWeather extends StatelessWidget {
  Forecast forecast;

  CurrentWeather({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 3,
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 7,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                      DataConverter().fromIcon(forecast.weather.first.icon)),
                  Text(
                    "${forecast.main.temp.toInt()} °C",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const Spacer(),
              Text(forecast.weather.first.description,
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                  "Min : ${forecast.main.temp_min.toInt()} °C - Max : ${forecast.main.temp_max.toInt()} °C",
                  style: Theme.of(context).textTheme.headlineSmall)
            ],
          ),
        ),
      ),
    );
  }
}
