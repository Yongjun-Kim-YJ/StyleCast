import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/login.dart';

<<<<<<< HEAD
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

=======

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

>>>>>>> nathan-branch
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase login"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//           if (!snapshot.hasData) {
//             return LoginWidget();
//           } else {
//             return Center(
//               child: Column(
//                 children: [
//                   Text("${snapshot.data.displayName}, Welcome"),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
<<<<<<< HEAD
//   }
// }

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.18, -0.98),
              end: Alignment(-0.18, 0.98),
              colors: [Color(0xFF9BBDF6), Color(0xFF0047BE)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 86,
                top: 403,
                child: Container(
                  height: 44,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/44x44"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 1,
                        child: Text(
                          'StyleCast',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 6,
                child: Container(
                  width: 347,
                  height: 47,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 62.38,
                          height: 47,
                          padding: const EdgeInsets.only(
                              top: 17, left: 24, bottom: 13),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '9:41',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF343434),
                                        fontSize: 17,
                                        fontFamily: 'SF Pro',
                                        fontWeight: FontWeight.w600,
                                        height: 0.06,
                                        letterSpacing: -0.50,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '􀋒',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF343434),
                                        fontSize: 14,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w600,
                                        height: 0.07,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 266.92,
                        top: 19,
                        child: Container(
                          width: 80.08,
                          height: 13,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 19.97,
                                height: 12,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 19.97,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://via.placeholder.com/20x12"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                width: 17,
                                height: 12.50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 17,
                                        height: 12.50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://via.placeholder.com/17x12"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                width: 27.33,
                                height: 13,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Opacity(
                                        opacity: 0.40,
                                        child: Container(
                                          width: 25,
                                          height: 13,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF343434)),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 2,
                                      top: 2,
                                      child: Container(
                                        width: 17,
                                        height: 9,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF343434),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 831,
                child: Container(
                  width: 393,
                  height: 21,
                  padding: const EdgeInsets.only(left: 130, right: 129),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 134,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
=======
//  }
>>>>>>> nathan-branch
