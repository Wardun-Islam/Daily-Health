import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/Home/components/body.dart';
import 'package:daily_health/Screens/Welcome/welcome_screen.dart';
import 'package:daily_health/pages/CallScreenAdapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        FirebaseFirestore.instance
            .collection("Online")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({"online": true});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CallScreenAdapter(
      widget: Scaffold(
        body: Body(),
      ),
    );
  }
}
