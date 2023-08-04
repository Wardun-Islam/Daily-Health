import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/DoctorScreen/utils/doctor.dart';
import 'package:daily_health/Screens/DoctorSpecialistScreen/components/doctor_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Body extends StatefulWidget {
  String specialist;
  Body({String specialist}) {
    this.specialist = specialist;
  }
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Doctor> doctors = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("doctors")
        .where("specialist", isEqualTo: widget.specialist)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        String image;
        firebase_storage.FirebaseStorage.instance
            .refFromURL(doc["image"])
            .getDownloadURL()
            .then((value) {
          image = value;
          doctors.add(new Doctor(
              doc.id,
              doc["name"],
              doc["degree"],
              doc["department"],
              doc["specialist"],
              doc["hospital"],
              doc["chamber"],
              doc["address"],
              doc["phone"],
              image,
              doc["experience"],
              doc["practic time"]));
          setState(() {
            doctors = doctors;
          });
        });
      });
      // print(doc["name"]);
      // print(doc["degree"]);
      // print(doc["department"]);
      // print(doc["specialist"]);
      // print(doc["hospital"]);
      // print(doc["chamber"]);
      // print(doc["address"]);
      // print(doc["phone"]);
      // print(doc["image"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: doctors.isEmpty
            ? Center(
                child: Text("Loading"),
              )
            : ListView.builder(
                itemCount: doctors.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return DoctorTile(doctor: doctors[index]);
                }),
      ),
    );
  }
}
