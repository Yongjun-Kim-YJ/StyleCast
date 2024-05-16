import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stylecast/src/pages/home.dart';
import 'package:stylecast/src/pages/weather_service.dart';
import 'add_location.dart';
import 'weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    _loadSavedLocations();
    _loadSelectedLocation();
  }

  Future<void> _loadSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? locations = prefs.getStringList('savedLocations');
    if (locations != null) {
      setState(() {
        savedLocations = locations;
      });
    }
  }

  Future<void> _loadSelectedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('selectedLocation');
    if (location != null) {
      setState(() {
        selectedLocation = location;
      });
    }
  }

  Future<void> _saveSelectedLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocation', location);
  }

  Future<void> _saveSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedLocations', savedLocations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 320,
              child: Text(
                'Location',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
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
                      position.latitude + 0.0183, position.longitude + 0.1697);
                  // San Jose
                  // Actual 37.348456, -121.854353
                  // Measured 37.33019742, -122.02406581
                  print(position.latitude);
                  print(position.longitude);
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
                    _saveSelectedLocation(currentLocation);
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
                  padding: const EdgeInsets.only(left: 30.0, right: 13),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (selectedLocation == savedLocations[index])
                            Icon(Icons.check),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'Delete') {
                                setState(() {
                                  savedLocations.removeAt(index);
                                });
                                _saveSavedLocations();
                                if (selectedLocation == savedLocations[index]) {
                                  _saveSelectedLocation('');
                                }
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
                        ],
                      ),
                      onTap: () {
                        setState(
                          () {
                            selectedLocation = savedLocations[index];
                            _saveSelectedLocation(savedLocations[index]);
                          },
                        );
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

                    _saveSavedLocations();
                    _saveSelectedLocation(result);

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
    _saveSavedLocations();
    super.dispose();
    if (selectedLocation != null) {
      List<String> locationParts = selectedLocation!.split(', ');
      String city = locationParts[0];
      String country = locationParts[1];

      Navigator.pop(context, {'city': city, 'country': country});
    }
  }
}
