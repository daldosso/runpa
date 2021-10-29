class ChallengeRun {
  int _id;
  String _date;
  String _description;

  ChallengeRun(this._date, this._description); // partecipants is optional

  ChallengeRun.withId(this._id, this._date, this._description);

  ChallengeRun.fromObject(dynamic o) {
    this._id = o["id"];
    this._date = o["run_date"];
    this._description = o["description"];
  }

  factory ChallengeRun.fromJson(Map<String, dynamic> json) {
    return ChallengeRun(
      json['run_date'],
      json['description'],
    );
  }

  factory ChallengeRun.fromMap(Map<String, Object> map) {
    return ChallengeRun(
      map['date'],
      map['description'],
    );
  }

  int get id => _id;
  String get date => _date;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["date"] = _date;
    map["description"] = _description;
    return map;
  }
}
