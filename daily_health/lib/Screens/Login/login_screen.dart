import 'package:flutter/material.dart';
import 'package:daily_health/Screens/Login/components/body.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;

  void setParentState(bool showSpinner) {
    setState(() {
      this.showSpinner = showSpinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Body(
          setParentStateFunction: setParentState,
        ),
      ),
    );
  }
}
