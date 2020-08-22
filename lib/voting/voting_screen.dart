import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/voting/detail_voting_screen.dart';
import 'package:jkh/voting/index.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({
    Key key,
  }) : super(key: key);

  @override
  VotingScreenState createState() {
    return VotingScreenState();
  }
}

class VotingScreenState extends State<VotingScreen> {
  VotingScreenState();

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
        return RefreshIndicator(
            child: !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: snapshot.data
                        .map((e) => Card(
                              child: ListTile(
                                title: Text(e.name),
                                onTap: () {
                                  Get.bottomSheet(VotingDetailsPage(
                                    voting: e,
                                  )).then((value) => _load);
                                },
                              ),
                            ))
                        .toList(),
                  ),
            onRefresh: () {
              return Future.microtask(() => _load);
            });
      },
      stream: BlocProvider.of<VotingCubit>(context).votings,
    );
  }

  void _load() {
    BlocProvider.of<VotingCubit>(context).loadAllVotings();
  }
}
