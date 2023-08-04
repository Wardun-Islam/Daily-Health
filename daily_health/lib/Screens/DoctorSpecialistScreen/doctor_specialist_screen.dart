import 'package:daily_health/Screens/DoctorSpecialistScreen/components/body.dart';
import 'package:flutter/cupertino.dart';

class DoctorSpecialistScreen extends StatelessWidget {
  String specialist;
  DoctorSpecialistScreen({String specialist}) {
    this.specialist = specialist;
  }
  @override
  Widget build(BuildContext context) {
    return Body(specialist: specialist);
  }
}
