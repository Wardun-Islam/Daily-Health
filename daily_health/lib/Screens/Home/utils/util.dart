import 'package:daily_health/Screens/Home/utils/speciality.dart';
import 'package:flutter/material.dart';

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities = <SpecialityModel>[];

  SpecialityModel specialityModel = new SpecialityModel();

  //1
  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Heart Specialist";
  specialityModel.imgAssetPath = "assets/images/doctor_icon.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //2
  specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Heart failure";
  specialityModel.imgAssetPath = "assets/images/doctor_icon.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //3
  specialityModel.noOfDoctors = 27;
  specialityModel.speciality = "Cardiology";
  specialityModel.imgAssetPath = "assets/images/doctor_icon.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  return specialities;
}
