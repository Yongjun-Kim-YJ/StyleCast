import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/sign_up_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;

  void _navigateToEmailVerification() async {
    if (_validateInputs()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: 'temporary_password', // 임시 비밀번호 사용
        );

        // 이메일 인증 요청 보내기
        User? user = _auth.currentUser;
        if (user != null) {
          await user.sendEmailVerification();
        }

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EmailVerificationScreen(email: _emailController.text.trim()),
          ),
        );
      } catch (e) {
        // 에러 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(e.toString().substring(e.toString().indexOf(' ') + 1))),
        );
        print(e);
      }
    }
  }

  bool _validateInputs() {
    bool isValid = true;
    String emailPattern = r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$';
    setState(() {
      _firstNameError = _firstNameController.text.isEmpty
          ? 'Please enter your first name'
          : null;
      _lastNameError = _lastNameController.text.isEmpty
          ? 'Please enter your last name'
          : null;
      _emailError = _emailController.text.isEmpty
          ? 'Please enter your email'
          : (!RegExp(emailPattern).hasMatch(_emailController.text)
              ? 'The email address is badly formatted'
              : null);

      isValid = _firstNameError == null &&
          _lastNameError == null &&
          _emailError == null;
    });
    return isValid;
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
              'General Information',
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                  'First Name',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _firstNameController,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: Color(0xFF777777),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _firstNameError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFFD5D5D5), // 테두리 색상
                                width: 1.5, // 테두리 두께
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _firstNameError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFF2979FF), // 포커스 시 테두리 색상
                                width: 1.5, // 포커스 시 테두리 두께
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_firstNameError != null) ...[
                        SizedBox(height: 5),
                        Text(
                          _firstNameError!,
                          style: TextStyle(
                            color: Color(0xffb3281f),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Name',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _lastNameController,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: Color(0xFF777777),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _lastNameError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFFD5D5D5), // 테두리 색상
                                width: 1.5, // 테두리 두께
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _lastNameError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFF2979FF), // 포커스 시 테두리 색상
                                width: 1.5, // 포커스 시 테두리 두께
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_lastNameError != null) ...[
                        SizedBox(height: 5),
                        Text(
                          _lastNameError!,
                          style: TextStyle(
                            color: Color(0xffb3281f),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Address',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _emailController,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: Color(0xFF777777),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _emailError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFFD5D5D5), // 테두리 색상
                                width: 1.5, // 테두리 두께
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _emailError != null
                                    ? Color(0xffb3281f)
                                    : Color(0xFF2979FF), // 포커스 시 테두리 색상
                                width: 1.5, // 포커스 시 테두리 두께
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_emailError != null) ...[
                        SizedBox(height: 5),
                        Text(
                          _emailError!,
                          style: TextStyle(
                            color: Color(0xffb3281f),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _navigateToEmailVerification,
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
