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
    return BlocBuilder<VotingCubit, List<Voting>>(builder: (context, state) {
      return state != null && state.length > 0
          ? RefreshIndicator(
              child: ListView(
                children: state
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(e.name),
                              onTap: () {
                                // Get.bottomSheet(
                                //     VotingDetailsPage(
                                //       voting: e,
                                //     ),
                                //     isDismissible: true,
                                //     enableDrag: true);
                                PersistentBottomSheetController pbsc =
                                    showBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => VotingDetailsPage(
                                    voting: e,
                                  ),
                                );
                                pbsc.closed.then((value) => _load);
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
              onRefresh: () {
                return Future.delayed(Duration(milliseconds: 10), () {
                  _load();
                });
              })
          : Center(
              child: CircularProgressIndicator(),
            );
    });
    // return StreamBuilder(
    //   builder: (context, AsyncSnapshot<List<Voting>> snapshot) {
    //     return !snapshot.hasData
    //         ? Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         :
    //   },
    //   stream: BlocProvider.of<VotingCubit>(context).votings,
    // );
  }

  void _load() {
    BlocProvider.of<VotingCubit>(context).loadAllVotings();
  }
}
