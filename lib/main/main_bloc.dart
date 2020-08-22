import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/data/repos/voting_repository.dart';
import 'package:jkh/main/index.dart';
import 'package:rxdart/rxdart.dart';

class MainCubit extends Cubit<List<Voting>> {
  MainCubit() : super([]);

  Stream<List<Voting>> get votings => _votingSubject.stream;
  final _votingSubject = BehaviorSubject<List<Voting>>();

  void loadAllVotings() async {
    List<Voting> newVotes = await VotingRepository().getAllVotings();
    _votingSubject.add(newVotes);
  }
}
