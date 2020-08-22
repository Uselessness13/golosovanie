import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {

  final List propss;
  AuthState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class UnAuthState extends AuthState {

  UnAuthState();

  @override
  String toString() => 'UnAuthState';
}

/// Initialized
class InAuthState extends AuthState {
  final String hello;

  InAuthState(this.hello) : super([hello]);

  @override
  String toString() => 'InAuthState $hello';

}

class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState(this.errorMessage): super([errorMessage]);
  
  @override
  String toString() => 'ErrorAuthState';
}
