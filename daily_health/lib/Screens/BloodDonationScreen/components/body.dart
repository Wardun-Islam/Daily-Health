import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/BloodDonationScreen/components/blood_donar_tile.dart';
import 'package:daily_health/Screens/BloodDonationScreen/util/bloodDoner.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<BloodDoner> doners = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('blood donation')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String image;
        FirebaseStorage.instance
            .refFromURL(doc["image"])
            .getDownloadURL()
            .then((value) {
          image = value;
          doners.add(new BloodDoner(doc["name"], doc["phone"],
              doc["bloodGroup"], doc["area"], image, doc["gender"]));
          setState(() {
            doners = doners;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: doners.isEmpty
            ? Center(
                child: Text("Loading"),
              )
            : ListView.builder(
                itemCount: doners.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return BloodDonorTile(doner: doners[index]);
                }),
      ),
    );
  }
}
