import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/AmbulanceScreen/componnts/ambulance_tile.dart';
import 'package:daily_health/Screens/AmbulanceScreen/utils/ambulance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Ambulance> ambulances = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('ambulance')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        FirebaseFirestore.instance
            .collection('ambulance')
            .doc(doc.id)
            .collection("dhaka")
            .get()
            .then((QuerySnapshot querySnapshot2) {
          querySnapshot2.docs.forEach((doc) {
            print("here");
            print(doc.id);
            String image;
            firebase_storage.FirebaseStorage.instance
                .refFromURL(doc["image"])
                .getDownloadURL()
                .then((value) {
              image = value;
              ambulances.add(new Ambulance(doc["name"], doc["email"],
                  doc["phone"], image, doc["address"]));
              setState(() {
                ambulances = ambulances;
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ambulances.isEmpty
            ? Center(
                child: Text("Loading"),
              )
            : ListView.builder(
                itemCount: ambulances.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return AmbulanceTile(ambulance: ambulances[index]);
                }),
      ),
    );
  }
}
