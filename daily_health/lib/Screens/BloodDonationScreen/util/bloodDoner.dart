class BloodDoner {
  String name;
  String phone;
  String bloodGroup;
  String area;
  String image;
  String gender;

  BloodDoner(this.name, this.phone, this.bloodGroup, this.area, this.image,
      this.gender);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> doner = new Map<String, dynamic>();
    doner['name'] = this.name;
    doner['phone'] = this.phone;
    doner['bloodGroup'] = this.bloodGroup;
    doner['area'] = this.area;
    doner['image'] = this.image;
    doner['gender'] = this.gender;
    return doner;
  }

  static BloodDoner fromMap(Map<String, dynamic> donerMap) {
    final BloodDoner doner = new BloodDoner(
        donerMap['name'],
        donerMap['phone'],
        donerMap['bloodGroup'],
        donerMap['area'],
        donerMap['image'],
        donerMap['gender']);
    return doner;
  }
}
