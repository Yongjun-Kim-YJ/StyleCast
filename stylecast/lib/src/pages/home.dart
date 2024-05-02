import 'package:flutter/material.dart';
import 'weather_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  String _city = 'San Jose';
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _forecastData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final weatherData = await _weatherService.getWeather(_city);
      final forecastData = await _weatherService.getForecast(_city);
      setState(() {
        _weatherData = weatherData;
        _forecastData = forecastData;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(_city),
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
    if (_weatherData == null || _forecastData == null) {
      return Center(child: Text('Error loading weather data'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Use Row and wrap in Padding for slight left shift
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0), // Adjust this for slight left shift
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    _getWeatherIconUrl(_weatherData!['weather'][0]['icon']),
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    '${_weatherData!['main']['temp'].toStringAsFixed(0)}°F',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Centered description
            Text(
              _weatherData!['weather'][0]['description'].toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            _buildTodayForecast(),
            SizedBox(height: 24),
            _buildWeeklyForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayForecast() {
    final today = _forecastData!['list'][0];
    final currentTemp = today['main']['temp'].toStringAsFixed(0);
    final maxTemp = today['main']['temp_max'].toStringAsFixed(0);
    final minTemp = today['main']['temp_min'].toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today: $currentTemp°F ~ $maxTemp°F',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOutfitIcon('assets/images/cardigan.png'),
            SizedBox(width: 16),
            _buildOutfitIcon('assets/images/tshirt.png'),
            SizedBox(width: 16),
            _buildOutfitIcon('assets/images/jeans.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildWeeklyForecast() {
    final forecast = _forecastData!['list'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...forecast.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          if (index % 8 == 0) {
            final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
            final dayOfWeek = _getDayOfWeek(date.weekday);
            final maxTemp = data['main']['temp_max'].toStringAsFixed(0);
            final minTemp = data['main']['temp_min'].toStringAsFixed(0);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dayOfWeek),
                  Row(
                    children: [
                      Image.network(
                        _getWeatherIconUrl(data['weather'][0]['icon']),
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 8),
                      Text('$minTemp° ~ $maxTemp°'),
                    ],
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        }).toList(),
      ],
    );
  }

  Widget _buildOutfitIcon(String assetPath) {
    return Image.asset(
      assetPath,
      width: 48,
      height: 48,
      color: Colors.grey,
    );
  }

  String _getDayOfWeek(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
