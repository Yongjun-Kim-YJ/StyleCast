import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextPage;

  SplashScreen({required this.nextPage});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  _navigateToNextPage() async {
    await Future.delayed(Duration(seconds: 2)); // 1초 대기
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.nextPage), // 다음 페이지로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment:
              Alignment.center, // Aligns children to the center of the stack
          children: [
            Image.asset(
              'assets/images/stylecast_splash.png',
              fit: BoxFit.cover, // Adjust to cover the entire screen
              height: MediaQuery.of(context).size.height, // Full screen height
              width: MediaQuery.of(context).size.width, // Full screen width
            ),
            Positioned(
              bottom:
                  300, // Adjust the vertical position of the CircularProgressIndicator
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
