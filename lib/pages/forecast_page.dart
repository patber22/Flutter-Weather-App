import 'package:finalproject/data_storage.dart';
import 'package:finalproject/ui/forecast_tile.dart';
import 'package:finalproject/ui/weather_functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForecastState();
  }
}

class _ForecastState extends State<Forecast> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final dataStorage = context.watch<DataStorage>();
    if (dataStorage.isLoading) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Loading weather data'),
          SizedBox(height: 10,),
          CircularProgressIndicator(),
        ],
      )
    );
    }
    if (dataStorage.forecast == null) {
    return const Center(child: Text('No forecast data available.'));
    }
    final forecast = dataStorage.forecast;
    return Container(
      color: getColor(dataStorage.currentWeather!.time.hour),
      child: Stack(
        children: [
          Positioned.fill(
            child: weatherAnimation(dataStorage.currentWeather!.id, this, false),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              children: [
                Text(
                  '5-Day Forecast for ${dataStorage.currentWeather!.cityName}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: context.read<DataStorage>().fetchData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text('Reload'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Weather data updated at: '
                  '${dataStorage.currentWeather?.time.hour.toString().padLeft(2, '0')}:'
                  '${dataStorage.currentWeather?.time.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(1, 1), color: Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...forecast!.entries.map((entry) {
                  final day = entry.key;
                  final forecasts = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ExpansionTile(
                      backgroundColor: const Color.fromARGB(255, 38, 100, 161),
                      collapsedBackgroundColor: const Color.fromARGB(255, 38, 100, 161),
                      title: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                          ],
                        ),
                      ),
                      children: forecasts.map((forecastEntry) {
                        return buildForecastTile(forecastEntry, this);
                      }).toList(),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 30),
                Text(
                  'Current: ${dataStorage.currentWeather!.description}, ${dataStorage.currentWeather!.temperature}°C',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                    ],
                  ),
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${dataStorage.currentWeather?.icon}@2x.png',
                  width: 125,
                  height: 125,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}  
