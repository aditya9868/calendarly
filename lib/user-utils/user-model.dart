import 'package:calendar/index.dart';

class UserModel {
  String college;
  num dob;
  String firstName;
  String lastName;
  String gender;

  String userName;

  UserModel({
    this.firstName,
    this.lastName,
    this.userName,
    this.college,
    this.dob,
    this.gender,
  });

  factory UserModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> parsedJson) {
    return UserModel(
      firstName: parsedJson.data()['firstName'],
      lastName: parsedJson.data()['lastName'],
      userName: parsedJson.data()['username'],
      dob: parsedJson.data()['dob'],
      college: parsedJson.data()['college'],
      gender: parsedJson.data()['gender'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = userName;
    data['dob'] = dob;

    data['college'] = college;
    data['gender'] = gender;
    return data;
  }
}
