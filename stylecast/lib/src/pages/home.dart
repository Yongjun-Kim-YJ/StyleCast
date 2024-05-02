// import 'package:flutter/material.dart';
// import 'weather_service.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final WeatherService _weatherService = WeatherService();
//   String _city = 'San Jose';
//   Map<String, dynamic>? _weatherData;
//   Map<String, dynamic>? _forecastData;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchWeatherData();
//   }

//   Future<void> _fetchWeatherData() async {
//     try {
//       final weatherData = await _weatherService.getWeather(_city);
//       final forecastData = await _weatherService.getForecast(_city);
//       setState(() {
//         _weatherData = weatherData;
//         _forecastData = forecastData;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   String _getWeatherIconUrl(String iconCode) {
//     return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu),
//         title: Text(
//           _weatherData != null
//               ? '${_weatherData!['name']}, ${_weatherData!['sys']['country']}'
//               : 'Weather App',
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _fetchWeatherData,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _buildWeatherContent(),
//     );
//   }

//   Widget _buildWeatherContent() {
//     if (_weatherData == null || _forecastData == null) {
//       return Center(child: Text('Error loading weather data'));
//     }

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     _getWeatherIconUrl(_weatherData!['weather'][0]['icon']),
//                     width: 120,
//                     height: 120,
//                   ),
//                   Text(
//                     '${_weatherData!['main']['temp'].toStringAsFixed(0)}°F',
//                     style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               _weatherData!['weather'][0]['description'].toUpperCase(),
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16),
//             StylecastWidget(),
//             SizedBox(height: 24),
//             TodayForecastWidget(forecastData: _forecastData!),
//             SizedBox(height: 24),
//             WeeklyForecastWidget(forecastData: _forecastData!),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Stylecast Widget
// class StylecastWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Stylecast',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Today: 74°F ~ 83°F', // Replace with dynamic data if available
//           style: TextStyle(fontSize: 16),
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildOutfitIcon('assets/images/cardigan.png'),
//             SizedBox(width: 16),
//             _buildOutfitIcon('assets/images/tshirt.png'),
//             SizedBox(width: 16),
//             _buildOutfitIcon('assets/images/jeans.png'),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildOutfitIcon(String assetPath) {
//     return Image.asset(
//       assetPath,
//       width: 48,
//       height: 48,
//       color: Colors.grey,
//     );
//   }
// }

// // Today Forecast Widget
// class TodayForecastWidget extends StatelessWidget {
//   final Map<String, dynamic> forecastData;

//   TodayForecastWidget({required this.forecastData});

//   @override
//   Widget build(BuildContext context) {
//     final today =
//         forecastData['list'][0]; // Sample forecast data, customize as needed

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Today',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // Replace these with real data
//             Column(
//               children: [
//                 Text('1 PM'),
//                 Text('83°F'),
//               ],
//             ),
//             Column(
//               children: [
//                 Text('2 PM'),
//                 Text('82°F'),
//               ],
//             ),
//             // Add more columns for each hour
//           ],
//         ),
//       ],
//     );
//   }
// }

// // Weekly Forecast Widget
// class WeeklyForecastWidget extends StatelessWidget {
//   final Map<String, dynamic> forecastData;

//   WeeklyForecastWidget({required this.forecastData});

//   @override
//   Widget build(BuildContext context) {
//     final forecast =
//         forecastData['list']; // Customize this to use actual weekly data

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Weekly',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         ...forecast.asMap().entries.map((entry) {
//           final index = entry.key;
//           final data = entry.value;
//           if (index % 8 == 0) {
//             final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
//             final dayOfWeek = _getDayOfWeek(date.weekday);
//             final maxTemp = data['main']['temp_max'].toStringAsFixed(0);
//             final minTemp = data['main']['temp_min'].toStringAsFixed(0);

//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(dayOfWeek),
//                   Row(
//                     children: [
//                       Image.network(
//                         'https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png',
//                         width: 32,
//                         height: 32,
//                       ),
//                       SizedBox(width: 8),
//                       Text('$minTemp° ~ $maxTemp°'),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }
//           return SizedBox.shrink();
//         }).toList(),
//       ],
//     );
//   }

//   String _getDayOfWeek(int dayOfWeek) {
//     switch (dayOfWeek) {
//       case 1:
//         return 'Monday';
//       case 2:
//         return 'Tuesday';
//       case 3:
//         return 'Wednesday';
//       case 4:
//         return 'Thursday';
//       case 5:
//         return 'Friday';
//       case 6:
//         return 'Saturday';
//       case 7:
//         return 'Sunday';
//       default:
//         return '';
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'package:intl/intl.dart'; // Add this import at the top

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String _getWeatherIconUrl(String iconCode) {
  return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
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
    if (_weatherData == null || _forecastData == null) {
      return Center(child: Text('Error loading weather data'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
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
            Text(
              _weatherData!['weather'][0]['description'].toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            StylecastWidget(forecastData: _forecastData!),
            SizedBox(height: 24),
            TodayForecastWidget(forecastData: _forecastData!),
            SizedBox(height: 24),
            WeeklyForecastWidget(forecastData: _forecastData!),
          ],
        ),
      ),
    );
  }
}

// Stylecast Widget
class StylecastWidget extends StatelessWidget {
  final Map<String, dynamic> forecastData;

  StylecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    final today = forecastData['list'][0];
    final maxTemp = today['main']['temp_max'].toStringAsFixed(0);
    final minTemp = today['main']['temp_min'].toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stylecast',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Today: $minTemp°F ~ $maxTemp°F',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
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

  Widget _buildOutfitIcon(String assetPath) {
    return Image.asset(
      assetPath,
      width: 48,
      height: 48,
      color: Colors.grey,
    );
  }
}

// Today Forecast Widget
class TodayForecastWidget extends StatelessWidget {
  final Map<String, dynamic> forecastData;

  TodayForecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final forecast = forecastData['list'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHourlyForecast(currentTime, forecast),
            _buildHourlyForecast(currentTime.add(Duration(hours: 1)), forecast),
            _buildHourlyForecast(currentTime.add(Duration(hours: 2)), forecast),
            _buildHourlyForecast(currentTime.add(Duration(hours: 3)), forecast),
            _buildHourlyForecast(currentTime.add(Duration(hours: 4)), forecast),
          ],
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(DateTime hour, List<dynamic> forecast) {
    final data = forecast.firstWhere(
      (item) =>
          DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000).hour ==
          hour.hour,
      orElse: () => null,
    );

    if (data != null) {
      return Column(
        children: [
          Text('${hour.hour.toString().padLeft(2, '0')}:00'),
          Image.network(
            _getWeatherIconUrl(data['weather'][0]['icon']),
            width: 32,
            height: 32,
          ),
          Text('${data['main']['temp'].toStringAsFixed(0)}°F'),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Helper function to get weather icon URL
  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}

// Weekly Forecast Widget
class WeeklyForecastWidget extends StatelessWidget {
  final Map<String, dynamic> forecastData;

  WeeklyForecastWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    final forecast = forecastData['list'];
    final today = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...forecast.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          if (index % 8 == 0) {
            final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
            final dayOfWeek = _getDayOfWeek(date.weekday);
            final isToday = date.day == today.day &&
                date.month == today.month &&
                date.year == today.year;
            final displayDay = isToday ? 'Today' : dayOfWeek;
            final dateString = _formatDate(date); // Use formatted date string
            final maxTemp = data['main']['temp_max'].toStringAsFixed(0);
            final minTemp = data['main']['temp_min'].toStringAsFixed(0);
            final iconUrl = _getWeatherIconUrl(data['weather'][0]['icon']);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayDay,
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold), // Bold and larger font size
                      ),
                      Text(
                        dateString,
                        style: TextStyle(
                            fontSize: 11), // Bold and larger font size
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Add weather icon before minimum temperature
                      Image.network(
                        iconUrl,
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 8), // Adjust spacing as needed
                      Text('$minTemp°'),
                      SizedBox(width: 8),
                      Container(
                        width:
                            100, // Adjust width to represent the temperature range
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('$maxTemp°'),
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

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date) + _ordinal(date.day);
  }

  String _ordinal(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
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
