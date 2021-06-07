import 'package:calendar/index.dart';
import 'package:http/http.dart' as http;
import 'package:calendar/utils/models.dart';

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

  Future<ProfileModel> getuser() async {
    String p = userName.replaceAll("@", "");
    p = p.replaceAll(".", "");
    try {
      final rawRes = await _firebaseFirestore.collection("users").doc(p).get();
      userCredential = ProfileModel.fromJson(rawRes);
      if(userCredential.role=="admin")
       await uploadEvents();
    } catch (e) {}
    return userCredential;
  }

  Future<void> uploadEvents() async {
    List<CodeForces> codeforces = [];
    List<CodeChef> codechef = [];

    try {
      //for code forces
      final forceUrl = Uri.parse("https://codeforces.com/api/contest.list");
      final res = await http.get(forceUrl);
      final p = HTTPBaseResponse.fromJson(res);
      if (p.success) {
        p.body['result'].forEach((ele) {
          codeforces.add(CodeForces.fromJson(ele));
        });
        final date = DateTime.now().subtract(Duration(days: 10));

        for (var item in codeforces) {
          if (date.microsecondsSinceEpoch <
              item.startingTime) if (await checkEvent(item.name)) {
            Map<String, dynamic> t = item.toJson();
            t.addAll({"addedBy": userCredential.userName});
            await _firebaseFirestore.collection("events").add(t);
          }
        }
      }
      //for code chef
      final chefUrl = Uri.parse("https://clients6.google.com/calendar/v3/calendars/codechef.com_3ilksfmv45aqr3at9ckm95td5g@group.calendar.google.com/events?calendarId=codechef.com_3ilksfmv45aqr3at9ckm95td5g%40group.calendar.google.com&singleEvents=true&timeZone=Asia%2FKolkata&maxAttendees=1&maxResults=250&sanitizeHtml=true&timeMin=2021-05-30T00%3A00%3A00%2B05%3A30&timeMax=2021-07-04T00%3A00%3A00%2B05%3A30&key=AIzaSyBNlYH01_9Hc5S1J9vuFmu2nUqBZJNAXxs");
      final chefres = await http.get(chefUrl);
      final q = HTTPBaseResponse.fromJson(chefres);
      if (q.success) {
        q.body['items'].forEach((ele) {
          codechef.add(CodeChef.fromJson(ele));
        });
        final date = DateTime.now().subtract(Duration(days: 10));

        for (var item in codechef) {
          if (date.microsecondsSinceEpoch <
              item.startTime) if (await checkEvent(item.summary)) {
            Map<String, dynamic> t = item.toJson();
            t.addAll({"addedBy": userCredential.userName});
            await _firebaseFirestore.collection("events").add(t);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkEvent(String str, {String type}) async {
    try {
      final res = await _firebaseFirestore
          .collection("events")
          .where("title", isEqualTo: str)
          .get();

      if (res.docs.length == 0) return true;
    } on FirebaseAuthException catch (e) {} catch (e) {}
    return false;
  }
}
