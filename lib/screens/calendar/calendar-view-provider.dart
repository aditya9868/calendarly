import 'package:calendar/index.dart';

class CalendarProvider with ChangeNotifier {
  Credential cred;
  CalendarProvider({this.cred});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<ViewCalendar>> getSchedule() async {
    String p = cred.userName.replaceAll("@", "");
    DateTime now = DateTime.now();
    int t = DateTime(now.year, now.month, now.day).microsecondsSinceEpoch;
    p = p.replaceAll(".", "");
    final response = await _firebaseFirestore
        .collection("users")
        .doc(p)
        .collection("calendar")
        .orderBy("startedAt", descending: true)
        .where("startedAt", isGreaterThanOrEqualTo: t)  
        .get();

    final re = response.docs.map((QueryDocumentSnapshot d) {
      return CalendarItemModel.fromJson(d).toCalendar();
    }).toList();
    return re;
  }
}
