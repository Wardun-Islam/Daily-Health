import 'package:flutter/material.dart';
import 'package:daily_health/Screens/Signup/components/body.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        child: SafeArea(
          child: Body(
            setParentStateFunction: setParentState,
          ),
        ),
      ),
    );
  }
}
