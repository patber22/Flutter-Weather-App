import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/current_weather_page.dart';
import 'pages/forecast_page.dart';
import 'pages/about_page.dart';
import 'data_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(); 
  runApp(
    ChangeNotifierProvider(
      create: (_) => DataStorage(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CurrentWeather(),
    Forecast(),
    About(),
  ];

  void _barTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather app',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.blueGrey[700],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GNav(
            activeColor: Colors.white,
            iconSize: 30,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabBackgroundColor: Colors.blueGrey,
            color: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Current',
              ),
              GButton(
                icon: Icons.timeline,
                text: 'Forecast',
              ),
              GButton(
                icon: Icons.info,
                text: 'About',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) => _barTapped(index),
          ),
        ),
      ),
    );
  }
}