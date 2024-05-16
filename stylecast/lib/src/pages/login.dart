import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylecast/src/pages/home.dart';
import 'package:stylecast/src/pages/sign_up.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        // 로그인 성공 후 HomePage로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
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

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _usernameController.text,
          password: _passwordController.text,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevent Bottom Overflow
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF343434),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFF343434)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Color(0xFFD5D5D5), width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xFF343434)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Color(0xFFD5D5D5), width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // 비밀번호 찾기 로직
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xFF2979FF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _signInWithGoogle,
                          child: Image.asset(
                            'assets/images/google_logo.png',
                            width: 62,
                            height: 62,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // 애플 로그인 로직 추가
                          },
                          child: Image.asset(
                            'assets/images/facebook_logo.png',
                            width: 62,
                            height: 62,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _signInWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2979FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        minimumSize: Size(271, 46),
                      ),
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpScreen()), // Navigate to SignUpScreen
                        );
                      },
                      child: Text(
                        'Create a New Account',
                        style: TextStyle(
                          color: Color(0xFF343434),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
