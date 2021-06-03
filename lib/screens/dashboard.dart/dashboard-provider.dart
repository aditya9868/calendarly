import 'package:calendar/index.dart';
import 'package:calendar/screens/add-event/add-event-model.dart';

class DashboardProvider with ChangeNotifier {
  Credential cred;
  DashboardProvider({this.cred});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<CalendarItemModel>> get getEventStream {
    DateTime now = DateTime.now();
    int t = DateTime(now.year, now.month, now.day).microsecondsSinceEpoch;
    return _firebaseFirestore
        .collection("events")
        .where("startedAt", isGreaterThanOrEqualTo: t)
        .orderBy("startedAt", descending: true)
        .snapshots()
        .map((QuerySnapshot list) => list.docs.map((QueryDocumentSnapshot d) {
              return CalendarItemModel.fromJson(d);
            }).toList());
  }
}
