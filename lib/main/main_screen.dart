import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/main/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  MainScreenState();

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
    return StreamBuilder(
      builder: (context, AsyncSnapshot<List<Voting>> snapshot) {
        return !snapshot.hasData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: snapshot.data
                    .map((e) => Card(
                          child: ListTile(
                            title: Text(e.name),
                          ),
                        ))
                    .toList(),
              );
      },
      stream: BlocProvider.of<MainCubit>(context).votings,
    );
  }

  void _load() {
    BlocProvider.of<MainCubit>(context).loadAllVotings();
  }
}
