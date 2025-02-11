import 'package:runpa/pages/team.dart';

class ChallengeRun {
  int _id = 0;
  DateTime _date = DateTime.now();
  String _description = "";

  ChallengeRun(this._date, this._description); // partecipants is optional

  ChallengeRun.withId(this._id, this._date, this._description);

  ChallengeRun.fromObject(dynamic o) {
    this._id = o["id"];
    this._date = o["run_date"];
    this._description = o["description"];
  }

  factory ChallengeRun.fromJson(Map<String, dynamic> json) {
    return ChallengeRun(
      DateTime.parse(json['run_date']),
      json['description'],
    );
  }

  factory ChallengeRun.fromMap(Map<String, Object> map) {
    return ChallengeRun(
      DateTime.parse(map['date'] as String),
      map['description'] as String,
    );
  }

  int get id => _id;
  DateTime get date => _date;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["date"] = _date;
    map["description"] = _description;
    return map;
  }
}

class ChallengeAthlete extends Athlete {
  late String score;

  ChallengeAthlete(
      {required super.lastName,
      required super.id,
      required super.firstName,
      required super.photo});

  static fromJson(element) {}
}
