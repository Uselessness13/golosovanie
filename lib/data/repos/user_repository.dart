import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/repos/base_repository.dart';

class UserRepository extends BaseRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() => _singleton;

  UserRepository._internal();

  Future<String> authUser(User user) async {
    return Future.value('ok');
  }
}
