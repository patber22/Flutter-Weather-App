import 'package:finalproject/ui/weather_functions.dart';
import 'package:finalproject/weather_models/forecast_model.dart';
import 'package:flutter/material.dart';

Widget buildForecastTile(ForecastModel forecastEntry, TickerProvider tp) {
  return Container(
    height: 100,
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(color: getColor(forecastEntry.time.hour)),
        weatherAnimation(forecastEntry.id, tp, true),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: 
              Text(
              '${forecastEntry.time.hour.toString().padLeft(2, '0')}:00\n'
              'Temperature: ${forecastEntry.temperature}°C\n'
              'Description: ${forecastEntry.description}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Image.network(
          'https://openweathermap.org/img/wn/${forecastEntry.icon}@2x.png',
          width: 80,
          height: 80,
        ),
      ],
    ),
  );
}