import 'package:calendar/index.dart';
import 'package:calendar/screens/add-event/add-event-model.dart';

class AddEventProvider with ChangeNotifier {
  Credential cred;
  AddEventProvider({this.cred});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<BaseResponse> addEvent(AddEventModel event) async {
    String p = cred.userName.replaceAll("@", "");
    p = p.replaceAll(".", "");

    try {
      if (event.isPrivate) {
        await _firebaseFirestore
            .collection("users")
            .doc(p)
            .collection("calendar")
            .add(event.toJson());
      } else {
        Map<String, dynamic> t = event.toJson();
        t.addAll({"addedBy": cred.userCredential.userName});
        print(t);
        await _firebaseFirestore.collection("events").add(t);
      }

      return BaseResponse(message: "Event Added", isSuccess: true);
    } on FirebaseAuthException catch (e) {
      return BaseResponse(message: e.message);
    } catch (e) {}
    return BaseResponse(message: "Error");
  }
}
