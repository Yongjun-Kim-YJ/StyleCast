import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsNotificationScreen extends StatefulWidget {
  final VoidCallback notificationToggleFunction;

  const SettingsNotificationScreen({super.key, required VoidCallback notificationFunction})
    : notificationToggleFunction = notificationFunction;

  @override
  _SettingsNotificationScreenState createState() => _SettingsNotificationScreenState();
}

class _SettingsNotificationScreenState extends State<SettingsNotificationScreen> {
  bool _isChecked = false; // 상태 변수 추가

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
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  width: 310,
                  height: 60,
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Enable Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        CupertinoSwitch(
                          value: _isChecked,
                          activeColor: CupertinoColors.activeBlue,
                          onChanged: (bool value) {
                            widget.notificationToggleFunction();
                            setState(() {
                              _isChecked = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 310,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      title: const Text(
                        'Set notification time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      onTap: () {
                        print('Set notification time tapped'); // 원하는 동작 추가
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
