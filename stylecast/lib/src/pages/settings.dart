import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/login.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10),
          AppBar(
            leading: Transform.translate(
              offset: Offset(15, 0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
                iconSize: 30,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      'Change username',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle navigation to change username page
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Change password',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle navigation to change password page
                    },
                  ),

                  //
                  //
                  // ///////// UNCOMMENT LATER //////////
                  //
                  //
                  // Divider(color: Colors.black),
                  // ListTile(
                  //   title: Text(
                  //     'Notifications',
                  //     style: TextStyle(
                  //       fontFamily: 'SF Pro',
                  //       fontSize: 24,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   trailing: Icon(Icons.arrow_forward_ios),
                  //   onTap: () {
                  //     // Handle navigation to notifications page
                  //   },
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     'Units',
                  //     style: TextStyle(
                  //       fontFamily: 'SF Pro',
                  //       fontSize: 24,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   trailing: Icon(Icons.arrow_forward_ios),
                  //   onTap: () {
                  //     // Handle navigation to units page
                  //   },
                  // ),
                  Divider(color: Colors.black),
                  ListTile(
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
