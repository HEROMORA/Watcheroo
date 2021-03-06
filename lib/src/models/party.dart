class Party {
  final String _id;
  final String _creator;
  final String _guest;
  final String _movieName;
  final String _status;
  final DateTime _createdAt;

  String get id => _id;
  String get creator => _creator;
  String get guest => _guest;
  String get movieName => _movieName;
  String get status => _status;
  DateTime get createdAt => _createdAt;

  Party.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        _creator = json['_creator'],
        _guest = json['_guest'],
        _movieName = json['movieName'],
        _status = json['status'],
        _createdAt = DateTime.parse(json['createdAt']);
}
