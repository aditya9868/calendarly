import 'package:calendar/index.dart';

class AddEventModel {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay startingTime;
  final TimeOfDay endingTime;
  final bool isPrivate;
  final bool isFullDay;
  final String color;

  AddEventModel({
    this.title,
    this.date,
    this.startingTime,
    this.endingTime,
    this.isPrivate,
    this.isFullDay,
    this.description,
    this.color,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['startedAt'] = CommonWidgets.convertTimeOfDay(startingTime, p: date)
        .microsecondsSinceEpoch;
    data['endedAt'] = CommonWidgets.convertTimeOfDay(endingTime, p: date)
        .microsecondsSinceEpoch;
    data['isfullDay'] = isFullDay;
    data['description'] = description;
    return data;
  }
}
