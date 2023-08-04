import 'package:daily_health/Screens/AmbulanceScreen/utils/ambulance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbulanceTile extends StatelessWidget {
  final Ambulance ambulance;
  AmbulanceTile({@required this.ambulance});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffF69383),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    ambulance.image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitHeight,
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
                  ambulance.name,
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
                  ambulance.phone,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.all(5),
                child: Text(
                  ambulance.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.all(5),
                child: Text(
                  ambulance.address,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
