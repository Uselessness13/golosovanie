import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/repos/base_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository extends BaseRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() => _singleton;

  UserRepository._internal();

  Stream<User> get user => _userSubject.stream;
  final _userSubject = BehaviorSubject<User>();

  Future<void> unAuthUser() async {
    _userSubject.add(null);
    return;
  }

  Future<String> authUser(User user) async {
    _userSubject.add(user);
    return Future.value('ok');
  }
}
