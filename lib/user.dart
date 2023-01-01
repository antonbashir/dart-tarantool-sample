import 'dart:async';

import 'package:tarantool_storage/tarantool_storage.dart';

class User {
  final int? id;
  final String firstname;
  final String surname;

  User({this.id, required this.firstname, required this.surname});

  List<dynamic> toTuple() => [id, firstname, surname];

  static User fromTuple(dynamic tuple) => User(id: tuple[0], firstname: tuple[1], surname: tuple[2]);

  @override
  String toString() => "User($id, $firstname, $surname)";
}

class UserSpace {
  final StorageSchema _schema;

  UserSpace(this._schema);

  Future<void> create() => _schema.createSpace("user", ifNotExists: true).then((value) => _schema.createIndex("user", "primary", ifNotExists: true));

  Future<void> drop() => _schema.dropSpace("user");

  Future<void> add(User user) => _schema.spaceByName("user").then((space) => space.put(user.toTuple()));

  Future<User> get(int id) => _schema.spaceByName("user").then((space) => space.get([id])).then(User.fromTuple);

  Future<List<User>> select() => _schema.spaceByName("user").then((space) => space.select()).then((users) => users.map(User.fromTuple).toList());

  Future<User> delete(int id) => _schema.spaceByName("user").then((space) => space.delete([id])).then(User.fromTuple);

  Stream<User> stream() async* {
    yield* await _schema.spaceByName("user").then((space) => space.iterator()).then((iterator) => iterator.stream(map: (value) => User.fromTuple(value)).cast());
  }
}
