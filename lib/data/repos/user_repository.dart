import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/repos/base_repository.dart';
import 'package:jkh/main.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository extends BaseRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() => _singleton;

  UserRepository._internal();

  Stream<User> get user => _userSubject.stream;
  final _userSubject = BehaviorSubject<User>();
  GetStorage box = GetStorage();

  Future<void> unAuthUser() async {
    box.remove("user");
    _userSubject.add(null);
    return;
  }

  Future<User> authUser(String userName) async {
    Client client = Client();
    try {
      Response response =
          await client.post(ROOT_URL + '/users', body: {"name": userName});
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        box.write("user", user);
        _userSubject.add(user);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }
}
