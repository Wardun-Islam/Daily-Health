import 'package:daily_health/Screens/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_health/Screens/Login/components/background.dart';
import 'package:daily_health/Screens/Signup/signup_screen.dart';
import 'package:daily_health/components/already_have_an_account_acheck.dart';
import 'package:daily_health/components/rounded_button.dart';
import 'package:daily_health/components/rounded_input_field.dart';
import 'package:daily_health/components/rounded_password_field.dart';

class Body extends StatefulWidget {
  final Function setParentStateFunction;
  const Body({@required this.setParentStateFunction});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  String password;
  bool isPasswordValid = true;
  bool isEmailValid = true;

  void validatePassword() {
    Pattern pattern = r'(^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$)';
    RegExp regex = new RegExp(pattern);
    if (password != null) {
      if (!regex.hasMatch(password)) {
        setState(() {
          isPasswordValid = false;
        });
      } else {
        setState(() {
          isPasswordValid = true;
        });
      }
    } else {
      setState(() {
        isPasswordValid = false;
      });
    }
  }

  void validateEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email != null) {
      if (!regex.hasMatch(email)) {
        setState(() {
          isEmailValid = false;
        });
      } else {
        setState(() {
          isEmailValid = true;
        });
      }
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login to your account",
              style: TextStyle(
                color: Colors.deepPurple[700],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/daily_health_login.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              icon: Icons.email,
              textInputType: TextInputType.emailAddress,
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  this.email = value;
                });
                validateEmail();
              },
              errorText: isEmailValid ? null : 'Enter Valid Email',
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  this.password = value;
                });
                validatePassword();
              },
              errorText: isPasswordValid ? null : 'Invalid Password',
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                widget.setParentStateFunction(true);
                validatePassword();
                validateEmail();
                if (isPasswordValid && isEmailValid) {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      widget.setParentStateFunction(false);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign In Failed!!!'),
                            content: Text('No user found for that email.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Sign Up'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignUpScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      widget.setParentStateFunction(false);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign In Failed!!!'),
                            content:
                                Text('Wrong password provided for that user.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      print('Wrong password provided for that user.');
                    }
                    widget.setParentStateFunction(false);
                  }
                }
                widget.setParentStateFunction(false);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
