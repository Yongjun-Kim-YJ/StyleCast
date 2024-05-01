import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylecast/src/pages/login.dart';


// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

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
//  }
