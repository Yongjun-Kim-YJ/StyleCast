// import 'package:flutter/material.dart';
// import 'package:stylecast/src/pages/weather_service.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final WeatherService _weatherService = WeatherService();
//   String temperature = '';
//   String weatherDescription = 'Loading...';
//   String weatherIcon = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadWeather();
//   }

//   Future<void> _loadWeather() async {
//     try {
//       var weatherData = await _weatherService.getWeather("San Jose");
//       setState(() {
//         temperature = '${weatherData['main']['temp']}°C';
//         weatherDescription =
//             weatherData['weather'][0]['description'].toString();
//         weatherIcon = _mapWeatherConditionToIcon(
//             weatherData['weather'][0]['main'].toString());
//       });
//     } catch (e) {
//       setState(() {
//         weatherDescription = "Failed to load weather data";
//       });
//     }
//   }

//   String _mapWeatherConditionToIcon(String condition) {
//     switch (condition) {
//       case 'Clear':
//         return '☀'; // Sunny
//       case 'Clouds':
//         return '☁'; // Cloudy
//       case 'Rain':
//         return '🌧'; // Rainy
//       case 'Snow':
//         return '❄'; // Snowy
//       default:
//         return '🌈'; // Default to something cheerful
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: Colors.black),
//           onPressed: () {},
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.sync, color: Colors.black),
//             onPressed: _loadWeather,
//           )
//         ],
//         title: Text('San Jose, CA', style: TextStyle(color: Colors.black)),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Text(weatherIcon, style: TextStyle(fontSize: 64)),
//                   SizedBox(height: 10),
//                   Text(temperature,
//                       style:
//                           TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
//                   Text(weatherDescription, style: TextStyle(fontSize: 20)),
//                 ],
//               ),
//             ),
//             // _buildStylecastCard(),
//             // _buildHourlyForecast(),
//             // _buildWeeklyForecast(),
//           ],
//         ),
//       ),
//     );
//   }

// //Come back to these three methods
//   // Widget _buildStylecastCard() {
//   //   // Implement this method based on your specific UI requirements
//   // }

//   // Widget _buildHourlyForecast() {
//   //   // Implement this method based on your specific UI requirements
//   // }

//   // Widget _buildWeeklyForecast() {
//   //   // Implement this method based on your specific UI requirements
//   // }
// }

import 'package:flutter/material.dart';
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
        weatherDescription =
            weatherData['weather'][0]['description'].toString();
        weatherIcon = _mapWeatherConditionToIcon(
            weatherData['weather'][0]['main'].toString());
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
                  Text(temperature,
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  Text(weatherDescription, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            _buildStylecastCard(),
            _buildHourlyForecast(),
            _buildWeeklyForecast(),
            _buildDetailedWeatherInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildStylecastCard() {
    // Sample data for clothing recommendation
    final clothingItems = [
      {'icon': Icons.card_giftcard, 'label': 'Cardigan'},
      {'icon': Icons.card_membership, 'label': 'T-Shirt'},
      {'icon': Icons.card_travel, 'label': 'Jeans'}
    ];

    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Stylecast', style: TextStyle(fontSize: 24)),
            Text('Today: 74°F ~ 83°F', style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: clothingItems.map((item) {
                return Column(
                  children: [
                    Icon(item['icon'] as IconData?, size: 32),
                    Text('label', style: TextStyle(fontSize: 16)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyForecast() {
    // Sample data for hourly forecast
    final hours = ['Now', '1 PM', '2 PM', '3 PM', '4 PM'];
    final temps = ['74°F', '78°F', '83°F', '82°F', '79°F'];
    final icons = ['☁', '☀', '☀', '☀', '☀'];

    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Today', style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(hours.length, (index) {
                return Column(
                  children: [
                    Text(icons[index], style: TextStyle(fontSize: 32)),
                    Text(temps[index], style: TextStyle(fontSize: 16)),
                    Text(hours[index], style: TextStyle(fontSize: 16)),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyForecast() {
    // Sample data for weekly forecast
    final days = ['Today', 'Tomorrow', 'Wednesday', 'Thursday'];
    final minTemps = ['68°F', '68°F', '76°F', '78°F'];
    final maxTemps = ['83°F', '76°F', '86°F', '90°F'];
    final icons = ['☁', '🌧', '☀', '☀'];

    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Weekly', style: TextStyle(fontSize: 24)),
            Column(
              children: List.generate(days.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(days[index], style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Text(icons[index], style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text('${minTemps[index]} - ${maxTemps[index]}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedWeatherInfo() {
    // Sample data for detailed weather info
    final info = {
      'Min. Temperature': '10°F',
      'Max. Temperature': '18°F',
      'Winds': '6 mph',
      'Precipitation': '14%',
      'Humidity': '68%',
      'Sunrise': '6:13 AM',
      'Sunset': '7:56 PM',
    };

    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: TextStyle(fontSize: 16)),
                  Text(entry.value, style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
