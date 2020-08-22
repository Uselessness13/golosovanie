import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkh/auth/index.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/login/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
    @required LoginBloc loginBloc,
  })  : _loginBloc = loginBloc,
        super(key: key);

  final LoginBloc _loginBloc;

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenState();
  final TextEditingController nameController = TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        cubit: widget._loginBloc,
        builder: (
          BuildContext context,
          LoginState currentState,
        ) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "GOЛОСОВАНИЕ",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.w900,
                        // color: Colors.white,
                      ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: key,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: nameController,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: Colors.white,
                                    ),
                                decoration: InputDecoration(
                                  labelText: 'Имя',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        // color: Colors.white,
                                      ),
                                  alignLabelWithHint: true,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                onPressed: () {
                                  if (key.currentState.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        AuthUserEvent(
                                            User(name: nameController.text)));
                                  }
                                },
                                child: Text(
                                  "ВОЙТИ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        fontWeight: FontWeight.w900,
                                        // color: Colors.white,
                                      ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          );
          if (currentState is UnLoginState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorLoginState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InLoginState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.hello),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._loginBloc.add(LoadLoginEvent());
  }
}
