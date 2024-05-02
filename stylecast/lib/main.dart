import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/home.dart';
import 'package:stylecast/src/pages/splash_screen.dart';
//import 'package:stylecast/src/pages/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      //home: SplashScreen(nextPage: HomePage()),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'StyleCast',
//       home: SplashScreen(nextPage: HomePage()), // SplashScreen으로 대체
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final WeatherService _weatherService = WeatherService();
//   String _weather = "Loading weather...";

//   @override
//   void initState() {
//     super.initState();
//     _loadWeather();
//   }

//   Future<void> _loadWeather() async {
//     try {
//       Map<String, dynamic> weatherData =
//           await _weatherService.getWeather("New York");
//       setState(() {
//         _weather =
//             "${weatherData['weather'][0]['description']} at ${weatherData['main']['temp']}°C";
//       });
//     } catch (e) {
//       setState(() {
//         _weather = "Failed to load weather data";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather Test'),
//       ),
//       body: Center(
//         child: Text(_weather),
//       ),
//     );
//   }
// }
