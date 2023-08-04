import 'package:daily_health/Screens/BloodDonationScreen/util/bloodDoner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BloodDonorTile extends StatelessWidget {
  final BloodDoner doner;
  BloodDonorTile({@required this.doner});
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Image.network(
                doner.image,
                height: 100,
                width: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  doner.name,
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
                  doner.gender,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  doner.bloodGroup,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  doner.phone,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  doner.area,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
