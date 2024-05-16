import 'package:flutter/material.dart';

class TempPrefPage extends StatelessWidget {
  final VoidCallback myFunction;
  TempPrefPage({required this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const SizedBox(
                  width: 320,
                  child: Text(
                    'Temperature',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'Change username',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print('Change username tapped');
                        // 원하는 동작 추가
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'Change password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print('Change password tapped');
                        // 원하는 동작 추가
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
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print('Notifications tapped');
                        // 원하는 동작 추가
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'Change units',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print('Units tapped');
                        myFunction();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.white,
                              //Dialog Main Title
                              title: const Column(
                                children: <Widget>[
                                  Text(
                                    "Unit Changed!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      "The temperature unit has been changed.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'SF Pro',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ]),

                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print('About Us tapped');
                        // 원하는 동작 추가
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
