import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:jkh/auth/index.dart';
import 'package:jkh/data/repos/user_repository.dart';
import 'package:jkh/utils/snacks.dart';
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
  final String user;

  AuthUserEvent(this.user);
  @override
  Stream<AuthState> applyAsync({AuthState currentState, AuthBloc bloc}) async* {
    try {
      yield UnAuthState();
      var auth = await UserRepository().authUser(user);
      if (auth != null)
        yield InAuthState('Hello world');
      else {
        SnackBarsCubit().showSnackBar("О Ш И Б К А");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAuthEvent', error: _, stackTrace: stackTrace);
      yield ErrorAuthState(_?.toString());
    }
  }
}
