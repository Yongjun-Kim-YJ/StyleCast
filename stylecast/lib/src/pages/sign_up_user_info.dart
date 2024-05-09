import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/sign_up_complete.dart';

class SignUpUserInfoScreen extends StatefulWidget {
  @override
  _SignUpUserInfoScreenState createState() => _SignUpUserInfoScreenState();
}

class _SignUpUserInfoScreenState extends State<SignUpUserInfoScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _navigateToSignUpComplete() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpCompleteScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(15, 0), // Adjust X and Y coordinates as needed
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
            iconSize: 30,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 43, right: 43, top: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'Create a new account',
              style: TextStyle(
                fontFamily: 'SF Pro',
                letterSpacing: -1,
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2979FF),
              ),
            ),
            Text(
              'Login Information',
              style: TextStyle(
                fontFamily: 'SF Pro',
                letterSpacing: 0,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF2979FF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF2979FF),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 76,
                  height: 4,
                  color: Color(0xFF2979FF),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF2979FF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF2979FF),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 76,
                  height: 4,
                  color: Color(0xFF2979FF),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF2979FF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF2979FF),
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF343434),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 307,
                  height: 50,
                  child: TextField(
                    controller: _usernameController,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Color(0xFF777777),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFD5D5D5), // 테두리 색상을 원하는 색상으로 변경하세요.
                          width: 1.5, // 테두리 두께를 원하는 두께로 변경하세요.
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF343434),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 307,
                  height: 50,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Color(0xFF777777),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFD5D5D5), // 테두리 색상을 원하는 색상으로 변경하세요.
                          width: 1.5, // 테두리 두께를 원하는 두께로 변경하세요.
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF343434),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 307,
                  height: 50,
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Color(0xFF777777),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFD5D5D5), // 테두리 색상을 원하는 색상으로 변경하세요.
                          width: 1.5, // 테두리 두께를 원하는 두께로 변경하세요.
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
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _navigateToSignUpComplete,
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
                        '  Next   ',
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
