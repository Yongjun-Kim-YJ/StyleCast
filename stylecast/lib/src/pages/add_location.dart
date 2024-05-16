import 'package:flutter/material.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  String? selectedLocation;

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
                          color: Color(0xFFD5D5D5), // 테두리 색상
                          width: 1.5, // 테두리 두께
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF2979FF), // 포커스 시 테두리 색상
                          width: 1.5, // 포커스 시 테두리 두께
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Perform location search based on the entered value
                      // Update the search results in the UI
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of search results
              itemBuilder: (context, index) {
                // Replace with the actual location data
                String location = 'Location $index';

                return ListTile(
                  title: Text(location),
                  onTap: () {
                    setState(() {
                      selectedLocation = location;
                    });
                  },
                  trailing:
                      selectedLocation == location ? Icon(Icons.check) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
