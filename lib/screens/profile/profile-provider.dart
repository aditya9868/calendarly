import 'package:calendar/index.dart';

class ProfileProvider with ChangeNotifier {
  Credential cred;
  ProfileProvider({this.cred});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ProfileModel profile = ProfileModel();
  String url;
  String get picUrl {
    if (profile.url == null) return url;
    return profile.url;
  }

  set setUrl(String u) {
    url = u;
    print(u);
    print("kmkdckjsknjcjs");
    notifyListeners();
  }

  Future<BaseResponse> addProfile(ProfileModel profileModel) async {
    String p = cred.userName.replaceAll("@", "");
    p = p.replaceAll(".", "");

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(p)
          .set(profileModel.toJson());

      return BaseResponse(message: "Event Added", isSuccess: true);
    } on FirebaseAuthException catch (e) {
      return BaseResponse(message: e.message);
    } catch (e) {}
    return BaseResponse(message: "Error");
  }
}
//
