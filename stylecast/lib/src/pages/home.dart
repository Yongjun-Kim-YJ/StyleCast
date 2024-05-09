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

  double latitude = 37.3382;
  double longtitude = -121.8863;
  Map<String, dynamic>? _currentWeatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final currentWeatherData = await _weatherService.getCurrentWeather(latitude, longtitude);
      // Using hardcoded coordinates for San Jose, adjust as necessary
      setState(() {
        _currentWeatherData = currentWeatherData;
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
          _currentWeatherData != null
              ? '${_currentWeatherData!['name']}, ${_currentWeatherData!['sys']['country']}'
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
  if (_currentWeatherData == null) {
    return Center(child: Text('Error loading weather data'));
  }

  // Adjust this to directly handle the list if that's what your service returns
  var currentWeatherData = _currentWeatherData!;

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          CurrentWidget(currentWeatherData: currentWeatherData),
          // StylecastWidget(currentWeatherData: currentWeatherData),
          SizedBox(height: 24),
          DetailWidget(currentWeatherData: currentWeatherData),
          // TodayForecastWidget(currentWeatherData: currentWeatherData),
          SizedBox(height: 24),
          // WeeklyForecastWidget(currentWeatherData: currentWeatherData),
        ],
      ),
    ),
  );
}




  // String _getWeatherIconUrl(String iconCode) {
  //   return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  // }
}


class CurrentWidget extends StatelessWidget{
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

class DetailWidget extends StatelessWidget{
  final Map<String, dynamic> currentWeatherData;

  DetailWidget({required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Text(
          'Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Min. Temperature: ${currentWeatherData['main']['temp_min'].toStringAsFixed(0)}°F'),
        Text('Max. Temperature: ${currentWeatherData['main']['temp_max'].toStringAsFixed(0)}°F'),
        Text('Windspeed: ${currentWeatherData['wind']['speed']} mph'),
        Text('Rain in 1hr: ${currentWeatherData['rain'] != null ? currentWeatherData['rain']['1h'] : 0}mm'),
        Text('Humidity: ${currentWeatherData['main']['humidity']}%'),
        Text('Sunrise: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(currentWeatherData['sys']['sunrise'] * 1000))}'),
        Text('Sunset: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(currentWeatherData['sys']['sunset'] * 1000))}'),
      ],
    );
  }

}



// class StylecastWidget extends StatelessWidget {
//   final Map<String, dynamic> currentWeatherData;

//   StylecastWidget({required this.currentWeatherData});

//   @override
//   Widget build(BuildContext context) {
//     double minTemp = double.infinity;
//     double maxTemp = double.negativeInfinity;
//     // for (var hourData in forecastData.take(4)) {
//     //   double temp = hourData['temp'].toDouble();
//     //   if (temp < minTemp) minTemp = temp;
//     //   if (temp > maxTemp) maxTemp = temp;
//     // }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Stylecast for Next Hours',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Temperature from ${minTemp.toStringAsFixed(0)}°F to ${maxTemp.toStringAsFixed(0)}°F',
//           style: TextStyle(fontSize: 16),
//         ),
//         SizedBox(height: 16),
//         // SingleChildScrollView(
//         //   scrollDirection: Axis.horizontal,
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: forecastData.take(4).map<Widget>((data) {
//         //       return Padding(
//         //         padding: const EdgeInsets.only(right: 16),
//         //         child: Column(
//         //           children: [
//         //             Image.network(
//         //               _getWeatherIconUrl(data['weather'][0]['icon']),
//         //               width: 48,
//         //               height: 48,
//         //             ),
//         //             Text('${data['temp'].toStringAsFixed(0)}°F'),
//         //           ],
//         //         ),
//         //       );
//         //     }).toList(),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// class TodayForecastWidget extends StatelessWidget {
//   final Map<String, dynamic> currentWeatherData;

//   TodayForecastWidget({required this.currentWeatherData});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Hourly Forecast',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Container(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: forecastData.length,
//             itemBuilder: (context, index) {
//               final hourData = forecastData[index];
//               final DateTime time = DateTime.fromMillisecondsSinceEpoch(hourData['dt'] * 1000);
//               final iconUrl = 'https://openweathermap.org/img/wn/${hourData['weather'][0]['icon']}@2x.png';
//               final temperature = hourData['temp'].toStringAsFixed(0);

//               return Container(
//                 width: 80,
//                 child: Column(
//                   children: [
//                     Text('${time.hour}:00', style: TextStyle(fontWeight: FontWeight.bold)),
//                     Image.network(iconUrl, width: 50, height: 50),
//                     Text('$temperature°F'),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class WeeklyForecastWidget extends StatelessWidget {
//   final Map<String, dynamic> currentWeatherData;

//   WeeklyForecastWidget({required this.currentWeatherData});


//   @override
//   Widget build(BuildContext context) {
//     Map<String, List<dynamic>> dailySummaries = {};
//     for (var entry in forecastData) {
//       String date = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(entry['dt'] * 1000));
//       if (!dailySummaries.containsKey(date)) {
//         dailySummaries[date] = [];
//       }
//       dailySummaries[date]?.add(entry);
//     }

//     List<Widget> dailyWidgets = dailySummaries.entries.map((entry) {
//       // Casting each value to double explicitly
//       double maxTemp = entry.value.map<double>((e) => (e['main']['temp_max'] as num).toDouble()).reduce(max);
//       double minTemp = entry.value.map<double>((e) => (e['main']['temp_min'] as num).toDouble()).reduce(min);
//       return ListTile(
//         title: Text(entry.key),
//         subtitle: Text('Max: $maxTemp°F, Min: $minTemp°F'),
//       );
//     }).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Daily Summaries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ...dailyWidgets,
//       ],
//     );
//   }
// }



//Trying this out
String geticonUrl(String iconCode) {
  return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}