import 'package:calendar/index.dart';
class ViewCalendarDataSource extends CalendarDataSource {
  ViewCalendarDataSource(List<ViewCalendar> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getViewCalendarData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getViewCalendarData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getViewCalendarData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getViewCalendarData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getViewCalendarData(index).isAllDay;
  }

  ViewCalendar _getViewCalendarData(int index) {
    final dynamic meeting = appointments[index];
    ViewCalendar meetingData;
    if (meeting is ViewCalendar) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class ViewCalendar {
  ViewCalendar(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

