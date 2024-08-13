class GroupedWeather {
  int min;
  int max;
  String description;
  String icon;
  String day;

  GroupedWeather(this.min, this.max, this.description, this.day, this.icon);

  String minAndMax() => "Min: $min°C - Max: $max°C";
}
