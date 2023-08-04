import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/chat_screen.dart';
import 'package:daily_health/pages/CallPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Call.dart';
import 'Screens/DoctorScreen/utils/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorsInfo extends StatefulWidget {
  Doctor doctor;
  DoctorsInfo({Key key, @required this.doctor});
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  Future<void> onJoin() async {
    String userid = FirebaseAuth.instance.currentUser.uid;
    String doctorid = widget.doctor.id;
    print(userid);
    print(doctorid);
    FirebaseFirestore.instance
        .collection("Online")
        .doc(widget.doctor.id)
        .get()
        .then((value) async {
      print(value.exists);
      print(doctorid);
      if (value.exists) {
        await _handleCameraAndMic(Permission.camera);
        await _handleCameraAndMic(Permission.microphone);
        final String postsURL =
            "https://daily-health-video-call-api.herokuapp.com/rtcToken/?channelName=${userid + doctorid}";
        await http.get(Uri.parse(postsURL)).then((response) async {
          if (response.statusCode == 200) {
            print(jsonDecode(response.body)["key"]);
            Call call = new Call(userid, doctorid,
                jsonDecode(response.body)["key"], userid + doctorid, true);
            await FirebaseFirestore.instance
                .collection("call")
                .doc(userid)
                .set(call.toMap());
            call.hasCalled = false;
            await FirebaseFirestore.instance
                .collection("call")
                .doc(doctorid)
                .set(call.toMap());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(call: call),
                ));
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Call abrupt!!!"),
                  content: Text("Can't make call right now."),
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
            print('Request failed with status: ${response.statusCode}.');
          }
        }).catchError((e) {
          print(e);
        });
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Call abrupt!!!"),
              content: Text("Doctor is not in online right now."),
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
    }).catchError((e) {
      print(e);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Call abrupt!!!"),
            content: Text("Doctor is not in online right now."),
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
    });
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    widget.doctor.image,
                    height: 200,
                    width: 200,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 48,
                              child: Text(
                                widget.doctor.name,
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 48,
                              child: Text(
                                widget.doctor.degree,
                                style:
                                    TextStyle(fontSize: 19, color: Colors.grey),
                              ),
                            ),
                            Text(
                              widget.doctor.specialist,
                              style:
                                  TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(
                                    Icons.textsms,
                                    size: 40,
                                    color: Colors.orangeAccent,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChatScreen(doctor: widget.doctor),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: onJoin,
                                  child: Icon(
                                    Icons.video_call,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "${widget.doctor.name} is a ${widget.doctor.specialist}, affiliated with multiple hospitals and "
                "has been in practice for more than ${widget.doctor.experience} years. ",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Hospital: ${widget.doctor.hospital}",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                "Chamber: ${widget.doctor.chamber}",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                "Phone: ${widget.doctor.phone}",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.place),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.black87.withOpacity(0.7),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 268,
                              child: Text(
                                widget.doctor.address,
                                style: TextStyle(color: Colors.grey),
                              ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.access_alarm),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Daily Practict",
                            style: TextStyle(
                                color: Colors.black87.withOpacity(0.7),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 268,
                              child: Text(
                                widget.doctor.practicTime,
                                style: TextStyle(color: Colors.grey),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
