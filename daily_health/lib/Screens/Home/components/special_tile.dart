import 'package:daily_health/Screens/DoctorSpecialistScreen/doctor_specialist_screen.dart';
import 'package:flutter/material.dart';

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile(
      {@required this.imgAssetPath,
      @required this.speciality,
      @required this.noOfDoctors,
      @required this.backColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              speciality,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "$noOfDoctors Doctors",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            SizedBox(
              height: 6,
            ),
            Image.asset(
              imgAssetPath,
              height: 100,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DoctorSpecialistScreen(specialist: speciality),
            ));
      },
    );
  }
}
