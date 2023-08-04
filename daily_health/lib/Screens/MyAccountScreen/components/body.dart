import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  void signOut() {
    FirebaseFirestore.instance
        .collection("Online")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
    FirebaseAuth.instance.signOut();
  }

  void passwordReset(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser.email;
    print(email);
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      print(email);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset password'),
            content: Text('An email has been sent at your mail.'),
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
    }).catchError((error) {
      print(email);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset password Failed!!!'),
            content: Text("Failed to send email for reset password : $error"),
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
      print("Failed to send Reset Email: $error");
    });
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              print(snapshot.data);
              print(FirebaseAuth.instance.currentUser.uid);
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset('assets/images/doctor_icon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Full Name: ${data['first_name']} ${data['last_name']}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Email: ${data['email']}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Mobile: ${data['mobile']}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              passwordReset(context);
                            },
                            child: Text("Change Password"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: signOut,
                            child: Text("Signout"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              return Text("loading");
            },
          ),
        ),
      ),
    );
  }
}
