import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/login.dart';
import 'package:stylecast/src/pages/weather_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  String temperature = '';
  String weatherDescription = 'Loading...';
  String weatherIcon = '';

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      var weatherData = await _weatherService.getWeather("San Jose");
      setState(() {
        temperature = '${weatherData['main']['temp']}°C';
        weatherDescription = weatherData['weather'][0]['description'].toString();
        weatherIcon = _mapWeatherConditionToIcon(weatherData['weather'][0]['main'].toString());
      });
    } catch (e) {
      setState(() {
        weatherDescription = "Failed to load weather data";
      });
    }
  }

  String _mapWeatherConditionToIcon(String condition) {
    switch (condition) {
      case 'Clear':
        return '☀'; // Sunny
      case 'Clouds':
        return '☁'; // Cloudy
      case 'Rain':
        return '🌧'; // Rainy
      case 'Snow':
        return '❄'; // Snowy
      default:
        return '🌈'; // Default to something cheerful
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sync, color: Colors.black),
            onPressed: _loadWeather,
          )
        ],
        title: Text('San Jose, CA', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(weatherIcon, style: TextStyle(fontSize: 64)),
                  SizedBox(height: 10),
                  Text(temperature, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  Text(weatherDescription, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            // _buildStylecastCard(),
            // _buildHourlyForecast(),
            // _buildWeeklyForecast(),
          ],
        ),
      ),
    );
  }

//Come back to these three methods
  // Widget _buildStylecastCard() {
  //   // Implement this method based on your specific UI requirements
  // }

  // Widget _buildHourlyForecast() {
  //   // Implement this method based on your specific UI requirements
  // }

  // Widget _buildWeeklyForecast() {
  //   // Implement this method based on your specific UI requirements
  // }
}