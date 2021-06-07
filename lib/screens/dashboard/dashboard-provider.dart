import 'package:calendar/index.dart';

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
        .orderBy(
          "startedAt",
        )
        .snapshots()
        .map((QuerySnapshot list) => list.docs.map((QueryDocumentSnapshot d) {
              return CalendarItemModel.fromJson(d);
            }).toList());
  }

  Future<BaseResponse> addEvent(CalendarItemModel event) async {
    String p = cred.userName.replaceAll("@", "");
    p = p.replaceAll(".", "");

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(p)
          .collection("calendar")
          .add(event.toJson());

      return BaseResponse(message: "Event Added", isSuccess: true);
    } on FirebaseAuthException catch (e) {
      return BaseResponse(message: e.message);
    } catch (e) {}
    return BaseResponse(message: "Error");
  }

  Future<BaseResponse> deleteEvent(CalendarItemModel event) async {
    String p = cred.userName.replaceAll("@", "");
    p = p.replaceAll(".", "");

    try {
      await _firebaseFirestore.collection("events").doc(event.id).delete();

      return BaseResponse(message: "Event Deleted", isSuccess: true);
    } on FirebaseAuthException catch (e) {
      return BaseResponse(message: e.message);
    } catch (e) {}
    return BaseResponse(message: "Error");
  }
}
