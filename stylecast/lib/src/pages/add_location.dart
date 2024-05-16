import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  String? selectedLocation;
  List<Placemark> searchResults = [];

  Future<void> _searchLocation(String query) async {
    if (query.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(query);
        if (locations.isNotEmpty) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            locations.first.latitude,
            locations.first.longitude,
          );
          setState(() {
            searchResults = placemarks;
          });
        } else {
          setState(() {
            searchResults = [];
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          searchResults = [];
        });
      }
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  String _getLocationString(Placemark placemark) {
    return placemark.locality ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, selectedLocation);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: SizedBox(
              width: 320,
              child: Text(
                'Add new location',
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
          SizedBox(height: 20),
          Container(
            width: 318,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Color(0xFF777777),
                    decoration: InputDecoration(
                      labelText: 'Search location',
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFD5D5D5),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF2979FF),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _searchLocation(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 38.0, top: 5, right: 38), // 원하는 왼쪽 패딩 값 설정
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  Placemark placemark = searchResults[index];
                  final locationString = _getLocationString(placemark);
                  return ListTile(
                    title: Text(locationString),
                    onTap: () {
                      setState(() {
                        selectedLocation = locationString;
                      });
                    },
                    trailing: selectedLocation == locationString
                        ? Icon(Icons.check)
                        : null,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
