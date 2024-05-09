import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weather_service.dart';  // Ensure this is correctly imported

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  String _city = 'San Jose';  // Example city, adjust as necessary
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _hourlyForecastData;  // To store hourly data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final weatherData = await _weatherService.getWeather(_city);
      // Using hardcoded coordinates for San Jose, adjust as necessary
      final hourlyForecastData = await _weatherService.getHourlyForecast(37.3382, -121.8863);
      setState(() {
        _weatherData = weatherData;
        _hourlyForecastData = hourlyForecastData['hourly'];  // Assuming 'hourly' is the correct key
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
        leading: Icon(Icons.menu),
        title: Text(
          _weatherData != null
              ? '${_weatherData!['name']}, ${_weatherData!['sys']['country']}'
              : 'Weather App',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchWeatherData,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildWeatherContent(),
    );
  }

Widget _buildWeatherContent() {
  if (_weatherData == null || _hourlyForecastData == null) {
    return Center(child: Text('Error loading weather data'));
  }

  // Adjust this to directly handle the list if that's what your service returns
  List<dynamic> hourlyList = _hourlyForecastData!['hourly'];  // Previously _hourlyForecastData['lit']

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Your existing widget code...
          StylecastWidget(forecastData: hourlyList),
          SizedBox(height: 24),
          TodayForecastWidget(forecastData: hourlyList),
          SizedBox(height: 24),
          WeeklyForecastWidget(forecastData: hourlyList),
        ],
      ),
    ),
  );
}




  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}

class StylecastWidget extends StatelessWidget {
  final List<dynamic> forecastData;

  StylecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    double minTemp = double.infinity;
    double maxTemp = double.negativeInfinity;
    for (var hourData in forecastData.take(4)) {
      double temp = hourData['temp'].toDouble();
      if (temp < minTemp) minTemp = temp;
      if (temp > maxTemp) maxTemp = temp;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stylecast for Next Hours',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Temperature from ${minTemp.toStringAsFixed(0)}°F to ${maxTemp.toStringAsFixed(0)}°F',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: forecastData.take(4).map<Widget>((data) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Image.network(
                      _getWeatherIconUrl(data['weather'][0]['icon']),
                      width: 48,
                      height: 48,
                    ),
                    Text('${data['temp'].toStringAsFixed(0)}°F'),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class TodayForecastWidget extends StatelessWidget {
  final List<dynamic> forecastData;

  TodayForecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hourly Forecast',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecastData.length,
            itemBuilder: (context, index) {
              final hourData = forecastData[index];
              final DateTime time = DateTime.fromMillisecondsSinceEpoch(hourData['dt'] * 1000);
              final iconUrl = 'https://openweathermap.org/img/wn/${hourData['weather'][0]['icon']}@2x.png';
              final temperature = hourData['temp'].toStringAsFixed(0);

              return Container(
                width: 80,
                child: Column(
                  children: [
                    Text('${time.hour}:00', style: TextStyle(fontWeight: FontWeight.bold)),
                    Image.network(iconUrl, width: 50, height: 50),
                    Text('$temperature°F'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WeeklyForecastWidget extends StatelessWidget {
  final List<dynamic> forecastData;

  WeeklyForecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    Map<String, List<dynamic>> dailySummaries = {};
    for (var entry in forecastData) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(entry['dt'] * 1000));
      if (!dailySummaries.containsKey(date)) {
        dailySummaries[date] = [];
      }
      dailySummaries[date]?.add(entry);
    }

    List<Widget> dailyWidgets = dailySummaries.entries.map((entry) {
      // Casting each value to double explicitly
      double maxTemp = entry.value.map<double>((e) => (e['main']['temp_max'] as num).toDouble()).reduce(max);
      double minTemp = entry.value.map<double>((e) => (e['main']['temp_min'] as num).toDouble()).reduce(min);
      return ListTile(
        title: Text(entry.key),
        subtitle: Text('Max: $maxTemp°F, Min: $minTemp°F'),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Summaries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...dailyWidgets,
      ],
    );
  }
}



//Trying this out
String _getWeatherIconUrl(dynamic weatherData) {
    // Safely access the weather icon
    if (weatherData != null && weatherData['weather'] != null && weatherData['weather'].isNotEmpty) {
      return 'https://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png';
    } else {
      return 'https://openweathermap.org/img/wn/01d@2x.png'; // Default icon if none found
    }
  }
