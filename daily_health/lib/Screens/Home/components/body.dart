import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_health/Screens/AmbulanceScreen/anbulance_screen.dart';
import 'package:daily_health/Screens/BloodDonationScreen/blood_donation_screen.dart';
import 'package:daily_health/Screens/DoctorScreen/doctor_screen.dart';
import 'package:daily_health/Screens/Home/components/special_tile.dart';
import 'package:daily_health/Screens/Home/utils/speciality.dart';
import 'package:daily_health/Screens/Home/utils/util.dart';
import 'package:daily_health/Screens/MyAccountScreen/my_account_screen.dart';
import 'package:daily_health/Screens/Nearbyhospital/nearby_hospital.dart';
import 'package:daily_health/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "";
  List<SpecialityModel> specialities;
  var _selectedIndex = 0;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot data) {
      if (data["first_name"] != null) {
        setState(() {
          name = data["first_name"];
          print(name);
        });
      }
    });
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();

    specialities = getSpeciality();
    FirebaseFirestore.instance
        .collection("doctors")
        .where("specialist", isEqualTo: "Heart Specialist")
        .get()
        .then((QuerySnapshot querySnapshot) {
      specialities[0].noOfDoctors = querySnapshot.docs.length;
    });
    FirebaseFirestore.instance
        .collection("doctors")
        .where("specialist", isEqualTo: "Heart failure")
        .get()
        .then((QuerySnapshot querySnapshot) {
      specialities[1].noOfDoctors = querySnapshot.docs.length;
    });
    FirebaseFirestore.instance
        .collection("doctors")
        .where("specialist", isEqualTo: "Cardiology")
        .get()
        .then((QuerySnapshot querySnapshot) {
      specialities[2].noOfDoctors = querySnapshot.docs.length;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyAccountScreen()));
      }
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 10.0),
          width: 60,
          height: 60,
          child: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              text: "Hi " + name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff013131),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '\nHow is your health?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ]),
        ),
        actions: <Widget>[
          IconButton(
              splashRadius: 15,
              splashColor: Colors.blue.shade50,
              icon: Icon(
                Icons.search,
                color: Colors.black87,
              ),
              onPressed: () {}),
          IconButton(
              splashRadius: 15,
              splashColor: Colors.blue.shade50,
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black87,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    'assets/images/doctor_icon.png'),
                              ),
                              Text(
                                'Doctor',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorScreen()),
                        );
                      },
                    ),
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(right: 3),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    'assets/images/ambulance_icon.png'),
                              ),
                              Text(
                                'Ambulance',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AmbulanceScreen()),
                        );
                      },
                    ),
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(right: 3),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    'assets/images/hospital_icon.png'),
                              ),
                              Text(
                                'Nearby Hospital',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NearbyhospitalScreen()),
                        );
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(left: 3, right: 1.5),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child:
                                    Image.asset('assets/images/blood_icon.png'),
                              ),
                              Text(
                                ' Blood Donation',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BloodDonation()),
                        );
                      },
                    ),
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(left: 1.5, right: 1.5),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    'assets/images/medicine_icon.png'),
                              ),
                              Text(
                                'Medicine',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.only(left: 1.5, right: 3),
                        width: size.width / 3 - 20,
                        height: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    'assets/images/medicare_icon.png'),
                              ),
                              Text(
                                'Med Care',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xfff1ebb8),
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                    border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.0)),
                  ),
                  height: 330,
                  padding: EdgeInsets.only(
                    top: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          bottom: 8,
                        ),
                        child: Text(
                          'Special Topics',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff131313)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          bottom: 8,
                        ),
                        child: Text(
                          'Discuss health directly with a doctor',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff5f5e5e)),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: specialities.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SpecialistTile(
                                imgAssetPath: specialities[index].imgAssetPath,
                                speciality: specialities[index].speciality,
                                noOfDoctors: specialities[index].noOfDoctors,
                                backColor: specialities[index].backgroundColor,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.ios_home,
              color: Colors.blueGrey,
            ),
            activeIcon: Icon(
              Ionicons.ios_home,
              color: Color(0xfd03a6b4),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MaterialCommunityIcons.blogger,
              color: Colors.blueGrey,
            ),
            activeIcon: Icon(
              MaterialCommunityIcons.blogger,
              color: Color(0xfd03a6b4),
            ),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.ios_person,
              color: Colors.blueGrey,
            ),
            activeIcon: Icon(
              Ionicons.ios_person,
              color: Color(0xfd03a6b4),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xfd03a6b4),
        onTap: _onItemTapped,
      ),
    );
  }
}
