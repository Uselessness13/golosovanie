import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/data/repos/user_repository.dart';
import 'package:jkh/data/repos/voting_repository.dart';
import 'package:rxdart/rxdart.dart';

class VotingCubit extends Cubit<List<Voting>> {
  VotingCubit() : super([]);

  Stream<List<Voting>> get votings => _votingSubject.stream;
  final _votingSubject = BehaviorSubject<List<Voting>>(sync: true);

  void loadAllVotings() async {
    List<Voting> newVotes = await VotingRepository().getAllVotings();
    _votingSubject.add(newVotes);
    emit(newVotes);
  }

  void vote(int answer, int voting) async {
    User user = await UserRepository().user.last;
    await VotingRepository().vote(user.id, answer, voting);
    loadAllVotings();
  }
}
