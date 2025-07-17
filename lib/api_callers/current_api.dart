import 'dart:convert';
import 'package:http/http.dart' as http;
import '../weather_models/current_weather_model.dart';

class CurrentApi {
  final String apiKey;

  CurrentApi({required this.apiKey});

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<CurrentWeatherModel?> fetchCurrentWeather(double lat, double lon) async {
    final url = '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      return CurrentWeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load JSON data');
    }
  }
}