import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTime(),
            _buildLocationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('3:14', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt), // Signal icon
              Icon(Icons.wifi), // WiFi icon
              Icon(Icons.battery_full), // Battery icon
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList() {
    return Column(
      children: [
        _locationItem('Cupertino, CA'),
        _locationItem('Seoul, Korea'),
        _addNewLocation(),
      ],
    );
  }

  Widget _locationItem(String location) {
    return ListTile(
      title: Text(location, style: TextStyle(fontSize: 24)),
      trailing: Icon(Icons.more_vert),
      onTap: () {
        // Handle location tap
      },
    );
  }

  Widget _addNewLocation() {
    return ListTile(
      title: Text('Add new location', style: TextStyle(fontSize: 24)),
      leading: Icon(Icons.add),
      onTap: () {
        // Handle add new location
      },
    );
  }
}
