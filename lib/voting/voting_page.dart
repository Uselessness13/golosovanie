import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkh/auth/auth_bloc.dart';
import 'package:jkh/auth/index.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/repos/user_repository.dart';
import 'package:jkh/voting/index.dart';

class VotingPage extends StatefulWidget {
  static const String routeName = '/voting';

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            }
            return Container();
          },
          stream: UserRepository().user,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(UnAuthEvent());
              })
        ],
      ),
      body: VotingScreen(),
    );
  }
}
