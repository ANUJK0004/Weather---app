class Weather {
  final String city;
  final int temperature;
  final int windSpeed;
  final int humidity;
  final int feelsLike;
  final int uv;
  final String condition;
  final String icon;
  // final int aqi;

  Weather({
    required this.city,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.feelsLike,
    required this.uv,
    required this.condition,
    required this.icon,

  });

  Weather.fromJson(Map<String, dynamic> json)
    : city = json['location']['name'],
      temperature = json['current']['temp_c'].toInt(),
      windSpeed = json['current']['wind_kph'].toInt(),
      humidity = json['current']['humidity'].toInt(),
      feelsLike = json['current']['feelslike_c'].toInt(),
      uv = json['current']['uv'].toInt(),
      condition = json['current']['condition']['text'],
      icon = json['current']['condition']['icon'];
}
