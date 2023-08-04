import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Call.dart';
import 'CallPage.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final String name;
  PickupScreen({@required this.call, this.name});

  @override
  Widget build(BuildContext context) {
    print(call);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 15),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("call")
                        .doc(call.callerId)
                        .delete();
                    await FirebaseFirestore.instance
                        .collection("call")
                        .doc(call.reciverId)
                        .delete();
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallPage(
                                  call: call,
                                )));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
