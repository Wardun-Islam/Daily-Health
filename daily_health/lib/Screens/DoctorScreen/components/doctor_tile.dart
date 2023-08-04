import 'package:daily_health/Screens/DoctorScreen/utils/doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../doctor_info.dart';

class DoctorTile extends StatelessWidget {
  final Doctor doctor;
  DoctorTile({@required this.doctor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorsInfo(doctor: doctor)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xffFBB97C),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      doctor.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        doctor.specialist,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    doctor.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 250,
                  child: Text(
                    doctor.degree,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    doctor.hospital,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
