class WeeklyForecast {
  final String date;
  final int minTemperature;
  final int maxTemperature;
  final String condition;
  final String icon;

  WeeklyForecast({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.condition,
    required this.icon,
});

  factory WeeklyForecast.fromJson(Map<String,dynamic>json){
    return WeeklyForecast(
      date : json['date'],
      minTemperature : json['day']['mintemp_c'].toInt(),
      maxTemperature : json['day']['maxtemp_c'].toInt(),
      condition : json['day']['condition']['text'],
      icon : json['day']['condition']['icon'],
    );
  }
}