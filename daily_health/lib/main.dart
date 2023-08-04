import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_health/Screens/Welcome/welcome_screen.dart';
import 'package:daily_health/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool userLoggedin = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (userLoggedin)
          await FirebaseFirestore.instance
              .collection("Online")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .delete();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        if (userLoggedin)
          await FirebaseFirestore.instance
              .collection("Online")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .set({"online": true});
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          userLoggedin = false;
        });
      } else {
        FirebaseFirestore.instance
            .collection("Online")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({"online": true});
        print('User is signed in!');
        setState(() {
          userLoggedin = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: userLoggedin ? HomeScreen() : WelcomeScreen(),
    );
  }
}
