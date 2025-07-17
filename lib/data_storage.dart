import 'package:finalproject/api_callers/current_api.dart';
import 'package:finalproject/api_callers/forecast_api.dart';
import 'package:finalproject/weather_models/current_weather_model.dart';
import 'package:finalproject/weather_models/forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'location_finder.dart';


class DataStorage extends ChangeNotifier {
  CurrentWeatherModel? currentWeather;
  Map<String, List<ForecastModel>>? forecast;
  bool isLoading = false;
  final locationfinder = LocationFinder();
  var position;
  final apiKey = dotenv.env['OPENWEATHERMAP_API_KEY']!;

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();


    try {
      position = await locationfinder.getLocation();
      final currentapi = CurrentApi(apiKey: apiKey);
      currentWeather = await currentapi.fetchCurrentWeather(position.latitude, position.longitude);
      final forecastapi = ForecastApi(apiKey: apiKey); 
      forecast = await forecastapi.fetchForecast(position.latitude, position.longitude);
    } catch (e){
      print('Error while fetching: $e');
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }
}