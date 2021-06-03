import 'package:calendar/index.dart';

class Credential with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String userName;
  ProfileModel userCredential = ProfileModel();

  bool get isLogin {
    if (userName == null)
      return false;
    else
      return true;
  }

  Future<void> storeUserData(String usr) async {
    userName = usr;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', json.encode({"userName": userName}));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var p = prefs.getKeys();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final data =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    userName = data['userName'];
    await getuser();
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userName = null;
    notifyListeners();
  }

  Future<UserModel> getuser() async {
    String p = userName.replaceAll("@", "");
    p=p.replaceAll(".", "");
    try {
      final rawRes = await _firebaseFirestore.collection("users").doc(p).get();
      userCredential = ProfileModel.fromJson(rawRes);
    } catch (e) {}
  }
}
