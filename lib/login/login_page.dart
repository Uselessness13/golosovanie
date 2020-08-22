import 'package:flutter/material.dart';
import 'package:jkh/login/index.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc(UnLoginState());

  @override
  Widget build(BuildContext context) {
    Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: LoginScreen(loginBloc: _loginBloc),
    );
  }
}
