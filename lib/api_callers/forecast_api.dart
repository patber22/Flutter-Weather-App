import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../weather_models/forecast_model.dart';

class ForecastApi {
  final String apiKey;

  ForecastApi({required this.apiKey});

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, List<ForecastModel>>> fetchForecast(double lat, double lon) async {
    final url = '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      final List<dynamic> jsonDataList = jsonData['list'];
      return groupByDay(jsonDataList.map((e) =>ForecastModel.fromJson(e)).toList());
    } else {
      throw Exception('Failed to load JSON data');
    }
  }

  Map<String, List<ForecastModel>> groupByDay(List<ForecastModel> list) {
    Map<String, List<ForecastModel>> groupedList = {};
    for (var forecast in list) {
      final date = DateFormat('EEEE, d MMM').format(forecast.time);
      if (!groupedList.containsKey(date)) {
        groupedList[date] = [];
      }
      groupedList[date]!.add(forecast);
    }
    return groupedList;
  }
}