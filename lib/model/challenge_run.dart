class ChallengeRun {
  int _id;
  String _date;
  String _distance;
  String _type;
  String _name;
  String _place;
  int _score;
  int _participants;

  ChallengeRun(this._date, this._distance, this._type, this._name, this._place,
      this._score,
      [this._participants]); // partecipants is optional

  ChallengeRun.withId(this._id, this._date, this._distance, this._type,
      this._name, this._place, this._score,
      [this._participants]);

  ChallengeRun.fromObject(dynamic o) {
    this._id = o["id"];
    this._date = o["date"];
    this._distance = o["distance"];
    this._type = o["type"];
    this._name = o["name"];
    this._place = o["place"];
    this._score = o["score"];
    this._participants = o["participants"];
  }

  factory ChallengeRun.fromJson(Map<String, dynamic> json) {
    return ChallengeRun(
      json['date'],
      json['name'],
      json['distance'],
      json['type'],
      json['name'],
      json['plase'],
      int.parse(json['score']),
    );
  }

  int get id => _id;
  String get date => _date;
  String get distance => _distance;
  String get type => _type;
  String get name => _name;
  String get place => _place;
  int get score => _score;
  int get participants => _participants;

  set participants(int value) {
    if (value > 0) {
      _participants = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["date"] = _date;
    map["distance"] = _distance;
    map["type"] = _type;
    map["name"] = _name;
    map["place"] = _place;
    map["score"] = _score;
    map["participants"] = _participants;

    return map;
  }
}
