import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stylecast/src/pages/home.dart';
import 'package:stylecast/src/pages/weather_service.dart';
import 'add_location.dart';
import 'weather_service.dart';
//import 'package:stylecast/src/pages/add_location.dart';

class LocationSettingsScreen extends StatefulWidget {
  @override
  _LocationSettingsScreenState createState() => _LocationSettingsScreenState();
}

class _LocationSettingsScreenState extends State<LocationSettingsScreen> {
  final WeatherService _weatherService = WeatherService();

  Map<String, dynamic>? _currentWeatherData;

  String? selectedLocation;
  List<String> savedLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Location',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            width: 340,
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                title: const Text(
                  'Use current location',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
                trailing: const Icon(Icons.location_searching),
                onTap: () async {
                  // 현재 위치 가져오기
                  LocationPermission permission =
                      await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied) {
                    permission = await Geolocator.requestPermission();
                    if (permission != LocationPermission.whileInUse &&
                        permission != LocationPermission.always) {
                      return;
                    }
                  }

                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  _currentWeatherData = await _weatherService.getCurrentWeather(
                      position.latitude, position.longitude);
                  String currentCity = _currentWeatherData!['name'];
                  String currentCountry =
                      _currentWeatherData!['sys']['country'];

                  String currentLocation = '$currentCity, $currentCountry';

                  // 리스트에 현재 위치 추가 (중복 방지)
                  if (!savedLocations.contains(currentLocation)) {
                    setState(() {
                      savedLocations.add(currentLocation);
                    });
                  }

                  // 현재 위치 선택
                  setState(() {
                    selectedLocation = currentLocation;
                  });

                  // // 현재 위치의 날씨 정보를 home.dart로 전달
                  // Navigator.pop(context,
                  //     {'city': currentCity, 'country': currentCountry});
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 280,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: savedLocations.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        savedLocations[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Delete') {
                            setState(() {
                              savedLocations.removeAt(index);
                            });
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          selectedLocation = savedLocations[index];
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 280,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 340,
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                title: const Text(
                  'Add new location',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                trailing: const Icon(Icons.add),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddLocationScreen()),
                  );

                  if (result != null && !savedLocations.contains(result)) {
                    setState(() {
                      savedLocations.add(result);
                      selectedLocation = result;
                    });

                    List<String> locationParts = selectedLocation!.split(', ');
                    String city = locationParts[0];
                    String country = locationParts[1];

                    Navigator.pop(context, {'city': city, 'country': country});
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (selectedLocation != null) {
      List<String> locationParts = selectedLocation!.split(', ');
      String city = locationParts[0];
      String country = locationParts[1];

      Navigator.pop(context, {'city': city, 'country': country});
    }
  }
}
