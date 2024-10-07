import 'package:weather_app/model/data_converter.dart';

class ApiResponse {
  String cod;
  int message;
  int cnt;
  List<Forecast> list;

  ApiResponse(this.cnt, this.cod, this.list, this.message);

  ApiResponse.fromJson(Map<String, dynamic> map)
      : cod = map["cod"],
        message = map["message"],
        cnt = map["cnt"],
        list = (map["list"] != null
            ? DataConverter()
                .listMappable(map["list"])
                .map((e) => Forecast.fromJson(e))
                .toList()
            : []);
}

class Forecast {
  Forecast(this.dt, this.main, this.weather, this.clouds, this.wind,
      this.visibility, this.dt_txt);
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  double visibility;
  String dt_txt;

  Forecast.fromJson(Map<String, dynamic> map)
      : dt = map["dt"],
        main = Main.fromJson(map["main"]),
        weather = DataConverter()
            .listMappable(map["weather"])
            .map((e) => Weather.fromJson(e))
            .toList(),
        clouds = Clouds.fromJson(map["clouds"]),
        wind = Wind.fromJson(map["wind"]),
        visibility = map["visibility"]?.toDouble() ?? 0.0,
        dt_txt = map["dt_txt"];
}

class Main {
  Main(this.temp, this.feels_like, this.temp_min, this.temp_max, this.pressure,
      this.sea_level, this.grnd_level, this.humidity, this.temp_kf);

  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  double pressure;
  double sea_level;
  double grnd_level;
  double humidity;
  double temp_kf;

  Main.fromJson(Map<String, dynamic> map)
      : temp = map["temp"].toDouble(),
        feels_like = map["feels_like"].toDouble(),
        temp_min = map["temp_min"].toDouble(),
        temp_max = map["temp_max"].toDouble(),
        pressure = map["pressure"].toDouble(),
        sea_level = map["sea_level"].toDouble(),
        grnd_level = map["grnd_level"].toDouble(),
        humidity = map["humidity"].toDouble(),
        temp_kf = map["temp_kf"].toDouble();
}

class Weather {
  Weather(this.id, this.main, this.description, this.icon);
  int id;
  String main;
  String description;
  String icon;

  Weather.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        main = map["main"],
        description = map["description"],
        icon = map["icon"];
}

class Clouds {
  Clouds(this.all);
  int all;
  Clouds.fromJson(Map<String, dynamic> map) : all = map["all"];
}

class Wind {
  Wind(this.speed, this.deg, this.gust);
  double speed;
  int deg;
  double gust;

  Wind.fromJson(Map<String, dynamic> map)
      : speed = map["speed"].toDouble(),
        deg = map["deg"],
        gust = map["gust"].toDouble();
}
