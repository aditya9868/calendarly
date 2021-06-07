import 'package:calendar/index.dart';

class CodeForces {
  final int id;
  final String name;
  final String type;
  final String phase;
  final int duration;
  final int startingTime;

  CodeForces({
    this.id,
    this.name,
    this.type,
    this.phase,
    this.duration,
    this.startingTime,
  });

  factory CodeForces.fromJson(Map<String, dynamic> parsedJson) {
    final start = DateTime.fromMillisecondsSinceEpoch(
        parsedJson['startTimeSeconds'] * 1000);
    return CodeForces(
      id: parsedJson['id'],
      name: parsedJson['name'],
      type: parsedJson['type'],
      phase: parsedJson['phase'],
      duration: parsedJson['durationSeconds'],
      startingTime: start.microsecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    final start =
        DateTime.fromMicrosecondsSinceEpoch(startingTime );
    data['title'] = name;
    data['startedAt'] = start.microsecondsSinceEpoch;
    data['endedAt'] =
        start.add(Duration(seconds: duration)).microsecondsSinceEpoch;
    data['isfullDay'] = false;
    data['type'] = "CodeForces";
    data['description'] =
        "Event: " + name + "\nPhase: " + phase + "\nType: " + type;
    return data;
  }
}

class CodeChef {
  final String summary;
  final String start;
  final String end;
  final String location;
  final String organiser;
  final int startTime;
  final int endTime;

  CodeChef({
    this.summary,
    this.start,
    this.end,
    this.location,
    this.organiser,
    this.startTime,
    this.endTime,
  });

  factory CodeChef.fromJson(Map<String, dynamic> parsedJson) {
    final start = parsedJson['start']['dateTime'];
    final end = parsedJson['end']['dateTime'];
    final _start = DateTime.parse(start);
    final _end = DateTime.parse(end);
    return CodeChef(
      summary: parsedJson['summary'],
      start: start,
      end: end,
      location: parsedJson['location'],
      organiser: parsedJson['organizer']['displayName'],
      endTime: _end.microsecondsSinceEpoch,
      startTime: _start.microsecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['title'] = summary;
    data['startedAt'] = startTime;
    data['endedAt'] = endTime;
    data['isfullDay'] = true;
    data['type'] = "CodeChef";
    data['description'] = organiser + "\nurl: " + location;
    return data;
  }
}
