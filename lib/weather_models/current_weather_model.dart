class CurrentWeatherModel {
  final String description;
  final double temperature;
  final String cityName;
  final int id;
  final String icon;
  final String country;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime time;
  final int humidity;
  final int clouds;
  final int wind;
  final double feelsLike;


  CurrentWeatherModel({
    required this.description,
    required this.temperature,
    required this.cityName,
    required this.id,
    required this.icon,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.time,
    required this.humidity,
    required this.clouds,
    required this.wind,
    required this.feelsLike,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
      id: json['weather'][0]['id'],
      icon: json['weather'][0]['icon'],
      country: json['sys']['country'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      humidity: json['main']['humidity'],
      clouds: json['clouds']['all'],
      wind: json['wind']['speed'].toInt(),
      feelsLike: json['main']['feels_like'].toDouble(),
    );
  }
}