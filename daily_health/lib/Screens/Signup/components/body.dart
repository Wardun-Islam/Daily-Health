import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_health/Screens/Login/login_screen.dart';
import 'package:daily_health/Screens/Home/home_screen.dart';
import 'package:daily_health/Screens/Signup/components/background.dart';
import 'package:daily_health/components/already_have_an_account_acheck.dart';
import 'package:daily_health/components/rounded_button.dart';
import 'package:daily_health/components/rounded_input_field.dart';
import 'package:daily_health/components/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  final Function setParentStateFunction;
  Body({@required this.setParentStateFunction});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String firstName;
  String lastName;
  String mobile;
  String email;
  String password1;
  String password2;
  bool isFirstNameValid = true;
  bool isLastNameValid = true;
  bool isMobileValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordMatched = true;
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(final uid) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(_auth.currentUser.uid)
        .set({
          'first_name': firstName,
          'last_name': lastName,
          'mobile': mobile, // John Doe
          'email': email // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void validatePasswordMatched() {
    if (password2 != null && password1 != null) {
      if (password1 == password2) {
        setState(() {
          isPasswordMatched = true;
        });
      } else {
        setState(() {
          isPasswordMatched = false;
        });
      }
    } else {
      if (password1 == null) {
        setState(() {
          isPasswordMatched = false;
        });
      }
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

  void validatePassword() {
    Pattern pattern = r'(^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$)';
    RegExp regex = new RegExp(pattern);
    if (password1 != null) {
      if (!regex.hasMatch(password1)) {
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

  void validateMobile() {
    Pattern pattern = r'(^(?:\+88|88)?(01[3-9]\d{8})$)';
    RegExp regex = new RegExp(pattern);
    if (mobile != null) {
      if (!regex.hasMatch(mobile)) {
        setState(() {
          isMobileValid = false;
        });
      } else {
        setState(() {
          isMobileValid = true;
        });
      }
    } else {
      setState(() {
        isMobileValid = false;
      });
    }
  }

  void validateName() {
    if (firstName == null)
      setState(() {
        isFirstNameValid = false;
      });
    else {
      if (firstName.isNotEmpty)
        setState(() {
          isFirstNameValid = true;
        });
      else {
        setState(() {
          isFirstNameValid = false;
        });
      }
    }
    if (lastName == null)
      setState(() {
        isLastNameValid = false;
      });
    else {
      if (lastName.isNotEmpty)
        setState(() {
          isLastNameValid = true;
        });
      else {
        setState(() {
          isLastNameValid = false;
        });
      }
    }
  }

  void validate() {
    validateEmail();
    validateName();
    validateMobile();
    validatePassword();
    validatePasswordMatched();
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
              "Create your account",
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            RoundedInputField(
              icon: Icons.person,
              textInputType: TextInputType.name,
              hintText: "First Name",
              onChanged: (value) {
                setState(() {
                  this.firstName = value;
                });
                validateName();
              },
              errorText: isFirstNameValid ? null : 'Enter Valid First Name',
            ),
            RoundedInputField(
              icon: Icons.person,
              textInputType: TextInputType.name,
              hintText: "Last Name",
              onChanged: (value) {
                setState(() {
                  this.lastName = value;
                });
                validateName();
              },
              errorText: isLastNameValid ? null : 'Enter Valid Last Name',
            ),
            RoundedInputField(
              icon: Icons.phone,
              textInputType: TextInputType.phone,
              hintText: "Mobile",
              onChanged: (value) {
                setState(() {
                  this.mobile = value;
                });
                validateMobile();
              },
              errorText: isMobileValid ? null : 'Enter Valid Mobile',
            ),
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
                  this.password1 = value;
                });
                validatePassword();
                validatePasswordMatched();
              },
              errorText: isPasswordValid
                  ? null
                  : 'Password must contain a letter, a digit and at least 8 character long',
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  this.password2 = value;
                });
                validatePassword();
                validatePasswordMatched();
              },
              errorText: isPasswordMatched ? null : 'Password not matched',
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                widget.setParentStateFunction(true);
                validate();
                if (isFirstNameValid &&
                    isLastNameValid &&
                    isEmailValid &&
                    isPasswordValid &&
                    isPasswordMatched &&
                    isMobileValid) {
                  try {
                    UserCredential userCredential =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password1);
                    if (userCredential != null) {
                      addUser(userCredential.user.uid);
                      widget.setParentStateFunction(false);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Successful!!!'),
                            content:
                                Text('Account has been created successfully'),
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false);
                    } else {
                      widget.setParentStateFunction(false);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Account creation failed'),
                            content: Text(
                                'An error occurs to creating your account. Please try again.'),
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
                    }
                  } on FirebaseAuthException catch (e) {
                    widget.setParentStateFunction(false);
                    if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign Up'),
                            content: Text(
                                'An account already exists for that email.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Sign In'),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
                    widget.setParentStateFunction(false);
                    print(e);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Account creation failed'),
                          content: Text(
                              'An error occurs to creating your account. Please try again.'),
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
                  }
                } else {
                  widget.setParentStateFunction(false);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
