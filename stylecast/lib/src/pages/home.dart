import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/login.dart';
import 'package:stylecast/src/pages/weather_service.dart';

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase login"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//           if (!snapshot.hasData) {
//             return LoginWidget();
//           } else {
//             return Center(
//               child: Column(
//                 children: [
//                   Text("${snapshot.data.displayName}, Welcome"),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//  }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  String _weather = "Loading weather...";

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      Map<String, dynamic> weatherData =
          await _weatherService.getWeather("New York");
      setState(() {
        _weather =
            "${weatherData['weather'][0]['description']} at ${weatherData['main']['temp']}°C";
      });
    } catch (e) {
      setState(() {
        _weather = "Failed to load weather data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Test'),
      ),
      body: Center(
        child: Text(_weather),
      ),
    );
  }
}
