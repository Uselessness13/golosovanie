import 'dart:async';
import 'dart:developer' as developer;

import 'package:jkh/auth/index.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {
  Stream<AuthState> applyAsync({AuthState currentState, AuthBloc bloc});
}

class UnAuthEvent extends AuthEvent {
  @override
  Stream<AuthState> applyAsync({AuthState currentState, AuthBloc bloc}) async* {
    await UserRepository().unAuthUser();
    yield UnAuthState();
  }
}

class AuthUserEvent extends AuthEvent {
  final User user;

  AuthUserEvent(this.user);
  @override
  Stream<AuthState> applyAsync({AuthState currentState, AuthBloc bloc}) async* {
    try {
      yield UnAuthState();
      var auth = await UserRepository().authUser(user);
      if (auth == 'ok') yield InAuthState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAuthEvent', error: _, stackTrace: stackTrace);
      yield ErrorAuthState(_?.toString());
    }
  }
}
