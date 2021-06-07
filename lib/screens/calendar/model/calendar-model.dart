import 'package:calendar/index.dart';

class CalendarItemModel {
  final int colorCode;
  final String title;
  final int startedAt;
  final int endedAt;
  final bool isfullDay;
  final String description;
  final String addedBy;
  final String type;
  final String id;

  CalendarItemModel({
    this.startedAt,
    this.endedAt,
    this.title,
    this.colorCode,
    this.isfullDay = false,
    this.description,
    this.addedBy,
    this.type,
    this.id,
  });
  factory CalendarItemModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> parsedJson) {
    return CalendarItemModel(
      startedAt: parsedJson.data()['startedAt'].toInt(),
      endedAt: parsedJson.data()['endedAt'].toInt(),
      title: parsedJson.data()['title'].toString(),
      isfullDay: parsedJson.data()['isfullDay'],
      description: parsedJson.data()['description'],
      addedBy: parsedJson.data()['addedBy'],
      type: parsedJson.data()['type'],
      id: parsedJson.id,
    );
  }

  ViewCalendar toCalendar() {
    return ViewCalendar(
        title,
        DateTime.fromMicrosecondsSinceEpoch(startedAt),
        DateTime.fromMicrosecondsSinceEpoch(endedAt),
        Color(CommonWidgets.getColorFromHex(
            CommonWidgets.convertAnyStringToHex(title))),
        false);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['startedAt'] = startedAt;
    data['endedAt'] = endedAt;
    data['isfullDay'] = isfullDay;
    data['description'] = description;
    data['type'] = type;
    return data;
  }
}
