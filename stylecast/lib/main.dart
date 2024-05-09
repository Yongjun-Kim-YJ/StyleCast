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
      //home: HomePage(),
      home: SplashScreen(nextPage: HomePage()),
    );
  }
}
