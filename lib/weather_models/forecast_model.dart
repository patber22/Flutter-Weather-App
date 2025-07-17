class ForecastModel {
  final DateTime time;
  final double temperature;
  final String description;
  final int id;
  final String icon;

  ForecastModel({
    required this.time,
    required this.temperature,  
    required this.description,
    required this.id,
    required this.icon
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      time: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      id: json['weather'][0]['id'],
      icon: json['weather'][0]['icon'],
    );
  }
}