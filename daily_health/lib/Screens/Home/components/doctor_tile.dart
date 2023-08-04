import 'package:flutter/material.dart';

class DoctorsTile extends StatelessWidget {
  final String imgAssetPath;
  final String doctor_name;
  final String speailist_type;
  DoctorsTile({@required this.imgAssetPath,@required this.doctor_name
    ,@required this.speailist_type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => DoctorsInfo()
        // ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffFFEEE0),
            borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.symmetric(horizontal: 24,
            vertical: 18),
        child: Row(
          children: <Widget>[
            Image.asset(imgAssetPath, height: 50,),
            SizedBox(width: 17,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(doctor_name, style: TextStyle(
                    color: Color(0xffFC9535),
                    fontSize: 19
                ),),
                SizedBox(height: 2,),
                Text(speailist_type, style: TextStyle(
                    fontSize: 15
                ),)
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,
                  vertical: 9),
              decoration: BoxDecoration(
                  color: Color(0xffFBB97C),
                  borderRadius: BorderRadius.circular(13)
              ),
              child: Text("Call", style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}