import 'package:calendar/index.dart';

class ProfileModel {
  final String first;
  final String last;
  final String college;
  final String year;
  final DateTime dob;
  final String codechef;
  final String codeforces;
  final String leetCode;
  final String userName;
  final String url;
  final String id;
  final String role;
  ProfileModel({
    this.first,
    this.last,
    this.college,
    this.year,
    this.dob,
    this.codechef,
    this.codeforces,
    this.leetCode,
    this.userName,
    this.url,
    this.id,
    this.role,
  });

  factory ProfileModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> parsedJson) {
    DateTime _dob;
    if (parsedJson.data()['dob'] == null) {
      try {
        _dob = DateTime.fromMicrosecondsSinceEpoch(parsedJson.data()['dob']);
      } catch (e) {}
    }
    return ProfileModel(
      first: parsedJson.data()['firstName'],
      last: parsedJson.data()['lastName'],
      college: parsedJson.data()['college'],
      year: parsedJson.data()['year'].toString(),
      dob: _dob,
      codechef: parsedJson.data()['codechef'],
      codeforces: parsedJson.data()['codeforces'],
      leetCode: parsedJson.data()['leetCode'],
      userName: parsedJson.data()['userName'],
      id: parsedJson.data()['id'],
      url: parsedJson.data()['url'],
      role: parsedJson.data()['role'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = first;
    data['lastName'] = last;
    data['college'] = college;
    data['year'] = year;
    data['dob'] = dob.microsecondsSinceEpoch;
    data['codechef'] = codechef;
    data['codeforces'] = codeforces;
    data['leetCode'] = leetCode;
    data['userName'] = userName;
    data['id'] = id;
    data['role'] = role;
    return data;
  }
}
