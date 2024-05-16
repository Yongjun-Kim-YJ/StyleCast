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
      appBar: AppBar(
        title: Text('Add Location'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search location',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Perform location search based on the entered value
                // Update the search results in the UI
              },
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
