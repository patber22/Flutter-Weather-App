import 'package:finalproject/ui/current_tile.dart';
import 'package:finalproject/ui/weather_functions.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/data_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CurrentWeatherState();
  }
}

class _CurrentWeatherState extends State<CurrentWeather> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataStorage>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataStorage = context.watch<DataStorage>();
    final current  = dataStorage.currentWeather;
    if (dataStorage.isLoading) {
    return Center(
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
    if (current == null) {
    return const Center(child: Text('No current weather data available.'));
    }
    return Container(
      color: getColor(current.time.hour),
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(child: weatherAnimation(current.id, this, true)),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  SizedBox(height: 35),
                  Center(
                    child: Text(
                      '${current.cityName}, ${current.country}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
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
                  Text(
                    DateFormat('EEE, MMM d, yyyy').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          color: Colors.black,
                        ),
                        ],
                      ),
                    ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${dataStorage.currentWeather?.icon}@2x.png',
                    width: 100,
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      current.description,
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      '${current.temperature}°C',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                  SizedBox(height: 20),
                  SizedBox(
                    height: 350,
                    width: 300,
                    child: Card(
                      elevation: 30,
                      shadowColor: Colors.blueGrey[100],
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                currentTile(
                                  CupertinoIcons.person,
                                  'Feels like:',
                                  '${current.feelsLike}°C'
                                ),
                                currentTile(
                                  CupertinoIcons.cloud,
                                  'Clouds:',
                                  '${current.clouds}%'
                                ),
                                currentTile(
                                  CupertinoIcons.sunrise,
                                  'Sunrise:',
                                  '${current.sunrise.hour.toString().padLeft(2, '0')}:${current.sunrise.minute.toString().padLeft(2, '0')}'
                                ),
                              ],
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                currentTile(
                                  CupertinoIcons.wind,
                                  'Wind:',
                                  '${current.wind}m/s'
                                ),
                                currentTile(
                                  CupertinoIcons.drop,
                                  'Humidity:',
                                  '${current.humidity}%'
                                ),
                                currentTile(
                                  CupertinoIcons.sunset,
                                  'Sunset:',
                                  '${current.sunset.hour.toString().padLeft(2, '0')}:${current.sunset.minute.toString().padLeft(2, '0')}'
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: context.read<DataStorage>().fetchData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text('Reload')
                  ),
                  Text(
                    'Weather data updated at: ${current.time.hour.toString().padLeft(2, '0')}:${current.time.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}  