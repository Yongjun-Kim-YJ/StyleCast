import 'package:flutter/material.dart';

class SignUpCompleteScreen extends StatefulWidget {
  @override
  _SignUpCompleteScreenState createState() => _SignUpCompleteScreenState();
}

class _SignUpCompleteScreenState extends State<SignUpCompleteScreen> {
  void _navigateToLogin() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 43, right: 43, top: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(height: 50),
            Text(
              'Account Created!',
              style: TextStyle(
                fontFamily: 'SF Pro',
                letterSpacing: -1,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/account_created.png',
                  width: 134,
                  height: 134,
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _navigateToLogin,
                child: Container(
                  width: 114,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Color(0xFF2979FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Login   ',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/next.png',
                        width: 10,
                        height: 17,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 104),
          ],
        ),
      ),
    );
  }
}
