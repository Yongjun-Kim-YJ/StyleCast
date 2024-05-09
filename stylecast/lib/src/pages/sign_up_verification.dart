import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylecast/src/pages/sign_up_user_info.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  EmailVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();
  }

  void _navigateToUserInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpUserInfoScreen(),
      ),
    );
  }

  void _sendVerificationEmail() async {}

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
              'Email Verification',
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
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/email_verification.png',
                  width: 134,
                  height: 134,
                ),
              ],
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Verify Your Email",
                style: TextStyle(
                  letterSpacing: -0.5,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Please click on the link in the email\nwe just sent you to confirm your address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SFProCondensed',
                  letterSpacing: -0.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Resend Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProCondensed',
                    letterSpacing: -0.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2979FF),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _navigateToUserInfo,
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
