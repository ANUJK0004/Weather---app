class HourlyForecast{

  final String icon;
  final int temperature;
  final String time;
  final String condition;

  HourlyForecast({
    required this.icon,
    required this.temperature,
    required this.time,
    required this.condition,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json){
    return HourlyForecast(
      icon : json['condition']['icon'],
      temperature : json['temp_c'].toInt(),
      time : json['time'],
      condition : json['condition']['text'],
    );
  }
}


