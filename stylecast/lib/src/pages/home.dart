// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weather_service.dart';  // Ensure this is correctly imported
import 'location.dart'; // Adjust the import path according to your folder structure


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();

  double latitude = 37.3382;
  double longitude = -121.8863;
  Map<String, dynamic>? _currentWeatherData;
  List<dynamic>? _forecastWeatherData;  // Assuming forecast data is a list
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final currentWeatherData = await _weatherService.getCurrentWeather(latitude, longitude);
      final forecastWeatherData = await _weatherService.getForecastWeather(latitude, longitude);
      setState(() {
        _currentWeatherData = currentWeatherData;
        _forecastWeatherData = forecastWeatherData['list'];  // Assuming API response structure
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text(
          _currentWeatherData != null
              ? '${_currentWeatherData!['name']}, ${_currentWeatherData!['sys']['country']}'
              : 'Weather App',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchWeatherData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildWeatherContent(),
    );
  }

  Widget _buildWeatherContent() {
    if (_currentWeatherData == null) {
      return const Center(child: Text('Error loading current weather data'));
    }
    if (_forecastWeatherData == null || _forecastWeatherData!.isEmpty) {
      return const Center(child: Text('Error loading forecast data'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Current Weather:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            CurrentWidget(currentWeatherData: _currentWeatherData!),
            const SizedBox(height: 24),
          // Assuming the StylecastWidget needs the current weather data
            StylecastWidget(currentWeatherData: _currentWeatherData!),
            const SizedBox(height: 24),
            // Text('5-Day Forecast:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            WeeklyForecastWidget(forecastData: _forecastWeatherData!),
            //Container(height: 1200, color: Colors.green),
            // ElevatedButton(
            //   onPressed: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => LocationPage()),
            //   );
            //},
            // child: Text('Open Location Page'),
          //), // The new button for navigation
          ],
        ),
      ),
    );
  }
}

class CurrentWidget extends StatelessWidget {
  final Map<String, dynamic> currentWeatherData;

  CurrentWidget({required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.fromMillisecondsSinceEpoch(currentWeatherData['dt'] * 1000);
    final iconUrl = 'https://openweathermap.org/img/wn/${currentWeatherData['weather'][0]['icon']}@2x.png';
    final temperature = currentWeatherData['main']['temp'].toStringAsFixed(0);
    final description = currentWeatherData['weather'][0]['description'];

    return Column(
      children: [
        Text('${time.hour}:${time.minute}'),
        Image.network(iconUrl, width: 100, height: 100),
        Text('$temperature°F'),
        Text(description),
      ],
    );
  }
}

class WeeklyForecastWidget extends StatelessWidget {
  final List<dynamic> forecastData;

  WeeklyForecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    Map<String, List<dynamic>> dailyForecasts = {};
    for (var forecast in forecastData) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(forecast['dt_txt']));
      if (!dailyForecasts.containsKey(date)) {
        dailyForecasts[date] = [];
      }
      dailyForecasts[date]!.add(forecast);
    }

    List<Widget> forecastWidgets = [];
    dailyForecasts.forEach((date, forecasts) {
      var maxTemp = forecasts.fold<double>(-273.15, (max, f) => math.max(max, f['main']['temp_max']));
      var minTemp = forecasts.fold<double>(double.infinity, (min, f) => math.min(min, f['main']['temp_min']));
      forecastWidgets.add(
        ListTile(
          title: Text(date),
          subtitle: Text('Max Temp: ${maxTemp.toStringAsFixed(1)}°F \n Min Temp: ${minTemp.toStringAsFixed(1)}°F'),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('5-Day Forecast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...forecastWidgets,
      ],
    );
  }
}

//Experimenting with StylecastWidget + getClothingRecommendation + WeatherInfo
class StylecastWidget extends StatelessWidget {
  //final Map<String, dynamic> forecastData;
  final Map<String, dynamic> currentWeatherData;

  StylecastWidget({required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    // Dummy data for clothing recommendations based on temperature.
    final temperature = currentWeatherData['main']['temp'];
    String clothingRecommendation = getClothingRecommendation(temperature);
    String temperatureString = temperature.toStringAsFixed(0);

    final iconUrl = 'https://openweathermap.org/img/wn/${currentWeatherData['weather'][0]['icon']}@2x.png';
    final description = currentWeatherData['weather'][0]['description'];

    return Container(
      padding: EdgeInsets.all(16),
      width: 330,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Stylecast',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WeatherInfo(
                iconUrl: iconUrl,
                temperature: temperatureString,
                description: description,
              ),
              Column(
                children: [
                  Text(
                    clothingRecommendation,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Image.asset('assets/images/clothing.png', width: 50, height: 50),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getClothingRecommendation(double temp) {
    if (temp > 25) {
      return 'T-Shirt & Shorts';
    } else if (temp > 15) {
      return 'Long Sleeve & Jeans';
    } else {
      return 'Jacket & Warm Pants';
    }
  }
}

class _WeatherInfo extends StatelessWidget {
  final String iconUrl;
  final String temperature;
  final String description;

  const _WeatherInfo({
    Key? key,
    required this.iconUrl,
    required this.temperature,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(iconUrl, width: 70, height: 70),
        Text('$temperature°F', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(description, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}


String geticonUrl(String iconCode) {
  return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}