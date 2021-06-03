class LoginModel {
  final String userName;
  final String password;

  LoginModel({this.userName, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.userName;
    if (this.password != null) data['password'] = this.password;
    return data;
  }
}
