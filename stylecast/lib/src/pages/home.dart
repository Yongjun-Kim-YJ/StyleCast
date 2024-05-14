// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
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
  Map<String, dynamic>? _forecastWeatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final currentWeatherData = await _weatherService.getCurrentWeather(latitude, longtitude);
      final forecastWeatherData = await _weatherService.getForecastWeather(latitude, longtitude);
      // Using hardcoded coordinates for San Jose, adjust as necessary
      setState(() {
        _currentWeatherData = currentWeatherData;
        _forecastWeatherData = forecastWeatherData;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text(
              _currentWeatherData != null
                  ? '${_currentWeatherData!['name']}, ${_currentWeatherData!['sys']['country']}'
                  : 'Weather App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
          ],
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
      return const Center(child: Text('Error loading weather data'));
    }
    if (_forecastWeatherData == null) {
      return const Center(child: Text('Error loading forecast data'));
    }

    var currentWeatherData = _currentWeatherData!;
    var forecastWeatherData = _forecastWeatherData!['list'];
    if (forecastWeatherData.isEmpty) {
      return const Center(child: Text('No forecast data available'));
    }

    List<dynamic> forecastWeatherDataList = forecastWeatherData;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, 0),
          end: Alignment(1, 1),
          colors: [
            Colors.white,
            Color.fromARGB(255, 223, 234, 255),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(child: CurrentWidget(currentWeatherData: currentWeatherData)),
              const SizedBox(height: 60),
              Center(child: StylecastWidget(forecastWeatherData: forecastWeatherDataList)),
              const SizedBox(height: 40),
              Center(child: NextHoursWidget(forecastWeatherData: forecastWeatherDataList)),
              const SizedBox(height: 40),
              Center(child: DetailsWidget(currentWeatherData: currentWeatherData, forecastWeatherData: forecastWeatherDataList)),
            ],
          ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$temperature°',
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              capitalizeFirstLetter(description.toString()),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Image.network(iconUrl, width: 32, height: 32, fit: BoxFit.fill)
          ],
        ),
        Text(
          'Last Updated On: ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class StylecastWidget extends StatelessWidget {
  final List<dynamic> forecastWeatherData;
  late final List<List<dynamic>> dailyMinMax;

  StylecastWidget({required this.forecastWeatherData}) {
    dailyMinMax = getDailyMinMaxTemperatures(forecastWeatherData);
  }

  @override
  Widget build(BuildContext context) {
    final minTemp = forecastWeatherData.isNotEmpty
        ? dailyMinMax[0][1].toString()
        : 'N/A';
    final maxTemp = forecastWeatherData.isNotEmpty
        ? dailyMinMax[0][2].toString()
        : 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 330,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 330,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stylecast',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                    ),
                    Container(
                      width: 330,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$minTemp° ~ $maxTemp°',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 14,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.bold,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 17,
                    ),
                    Container(
                      width: 330,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset('assets/images/cardigan.png').image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Cardigan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset('assets/images/tshirt.png').image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'T-Shirt',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset('assets/images/jeans.png').image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Jeans',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NextHoursWidget extends StatelessWidget {
  final List<dynamic> forecastWeatherData;

  NextHoursWidget({required this.forecastWeatherData});  

  @override
  Widget build(BuildContext context) {
    // 데이터가 충분한지 확인 (최소 8개 항목)
    if (forecastWeatherData.length < 8) {
      return const Center(child: Text('Not enough forecast data'));
    }

    final times = List.generate(8, (index) => formatTimeFromUnix(forecastWeatherData[index]['dt']));
    final temps = List.generate(8, (index) => forecastWeatherData[index]['main']['temp'].toStringAsFixed(0));
    final icons = List.generate(8, (index) => forecastWeatherData[index]['weather'][0]['icon']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 330,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 330,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Hours',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                    ),
                    Container(
                      width: 330,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(8, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    times[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${icons[index]}.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${temps[index]}°',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final Map<String, dynamic> currentWeatherData;
  final List<dynamic> forecastWeatherData;
  late final List<List<dynamic>> dailyMinMax;

  DetailsWidget({required this.currentWeatherData, required this.forecastWeatherData}) {
    dailyMinMax = getDailyMinMaxTemperatures(forecastWeatherData);
  }

  @override
  Widget build(BuildContext context) {
    final feelsLike = currentWeatherData['main']['feels_like'].toStringAsFixed(0);
    final minTemp = forecastWeatherData.isNotEmpty
        ? dailyMinMax[0][1].toString()
        : 'N/A';
    final maxTemp = forecastWeatherData.isNotEmpty
        ? dailyMinMax[0][2].toString()
        : 'N/A';
    final windSpeed = currentWeatherData['wind']['speed'].toString();
    final rain = currentWeatherData['rain'] != null ? currentWeatherData['rain']['1h'].toString() : '0';
    final humidity = currentWeatherData['main']['humidity'].toString();
    final sunrise = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(currentWeatherData['sys']['sunrise'] * 1000));
    final sunset = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(currentWeatherData['sys']['sunset'] * 1000));

    return Column(
      children: [
        SizedBox(
          width: 330,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 330,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Details',
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                    ),
                    Container(
                      height: 363,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 363,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Feels Like',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$feelsLike°', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Min. Temp.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$minTemp°', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Max. Temp.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$maxTemp°', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),



                                SizedBox(height: 25),
                                Container(
                                  width: 256,
                                  height: 1,
                                  decoration: const BoxDecoration(color: Color(0xFF1F1F1F)),
                                ),
                                SizedBox(height: 25),



                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Windspeed',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$windSpeed'' mph',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rains in 1hr',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$rain'' mm', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Humidity',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$humidity''%', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 25),
                                Container(
                                  width: 256,
                                  height: 1,
                                  decoration: const BoxDecoration(color: Color(0xFF1F1F1F)),
                                ),
                                SizedBox(height: 25),



                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunrises at',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$sunrise', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                                SizedBox(height: 25),

                                Center(child:
                                  SizedBox(
                                    width: 280,
                                    height: 17,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunsets at',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '$sunset', // Dynamic temperature
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'SF Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                
                                // Other similar modifications for max temp, wind speed, etc.
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 330,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xFFFfFfFf)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

List<int> getDistinctDateIndices(List<dynamic> weatherList) {
  List<int> indices = [];
  String? previousDate;

  for (int i = 0; i < weatherList.length; i++) {
    String currentDate = weatherList[i]['dt_txt'].split(' ')[0];
    if (previousDate != currentDate) {
      indices.add(i);
      previousDate = currentDate;
    }
  }
  return indices;
}

List<int> getTomorrowIndices(List<dynamic> weatherList, DateTime today) {
  List<int> indices = [];
  DateTime tomorrow = today.add(Duration(days: 1));
  String tomorrowDateStr = tomorrow.toIso8601String().split('T')[0];

  List<String> times = ['06:00:00', '09:00:00', '12:00:00', '15:00:00', '18:00:00', '21:00:00'];
  int foundCount = 0;

  for (int i = 0; i < weatherList.length; i++) {
    String dtTxt = weatherList[i]['dt_txt'];
    if (dtTxt.startsWith(tomorrowDateStr)) {
      String time = dtTxt.split(' ')[1];
      if (times.contains(time)) {
        indices.add(i);
        foundCount++;
        if (foundCount == 6) break;
      }
    }
  }
  return indices;
}

String formatTimeFromUnix(int dt) {
  // UNIX 타임스탬프를 DateTime 객체로 변환하고 로컬 시간으로 변환
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
  
  // 시간을 "h:mm a" 형식으로 변환
  String formattedTime = DateFormat.jm().format(dateTime);
  
  // ":00"을 제거하되 "AM" 또는 "PM"을 유지
  if (formattedTime.endsWith(":00 AM")) {
    formattedTime = formattedTime.replaceAll(":00 AM", " AM");
  } else if (formattedTime.endsWith(":00 PM")) {
    formattedTime = formattedTime.replaceAll(":00 PM", " PM");
  }
  
  return formattedTime;
}

List<List<dynamic>> getDailyMinMaxTemperatures(List<dynamic> forecastWeatherData) {
  Map<String, List<int>> dailyTemps = {};

  for (var item in forecastWeatherData) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000).toLocal();
    String dateStr = DateFormat('yyyy-MM-dd').format(dateTime);

    // temp_min과 temp_max를 double에서 int로 변환
    int tempMin = (item['main']['temp_min'] as num).toInt();
    int tempMax = (item['main']['temp_max'] as num).toInt();

    if (!dailyTemps.containsKey(dateStr)) {
      dailyTemps[dateStr] = [tempMin, tempMax];
    } else {
      dailyTemps[dateStr]![0] = tempMin < dailyTemps[dateStr]![0] ? tempMin : dailyTemps[dateStr]![0];
      dailyTemps[dateStr]![1] = tempMax > dailyTemps[dateStr]![1] ? tempMax : dailyTemps[dateStr]![1];
    }
  }

  List<List<dynamic>> result = [];
  dailyTemps.forEach((date, temps) {
    result.add([date, temps[0], temps[1]]);
  });
  print(result);
  return result;
}
