import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jkh/data/models/user.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/data/repos/user_repository.dart';
import 'package:jkh/data/repos/voting_repository.dart';
import 'package:jkh/voting/index.dart';

class VotingDetailsPage extends StatefulWidget {
  VotingDetailsPage({Key key, this.voting}) : super(key: key);
  final Voting voting;
  @override
  _VotingDetailsPageState createState() => _VotingDetailsPageState();
}

class _VotingDetailsPageState extends State<VotingDetailsPage> {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      maxChildSize: 0.8,
      builder: (context, controller) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.voting.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.voting.description,
                    // maxLines: 4,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Column(
                  children: widget.voting.answers
                      .map((e) => Card(
                            color: box.hasData(widget.voting.id.toString()) ??
                                    false
                                ? box.read(widget.voting.id.toString()) == e.id
                                    ? Colors.greenAccent
                                    : Theme.of(context).cardColor
                                : Theme.of(context).cardColor,
                            elevation: 2,
                            child: ListTile(
                              onTap: box.hasData(widget.voting.id.toString()) ??
                                      false
                                  ? () {
                                      if (Get.isSnackbarOpen)
                                        Navigator.pop(context);
                                      Get.snackbar(
                                          'Вы уже голосовали',
                                          widget.voting.answers
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  box.read(widget.voting.id
                                                      .toString()))
                                              .text,
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.grey[800],
                                          colorText: Colors.white,
                                          barBlur: 0.0,
                                          instantInit: true,
                                          backgroundGradient: LinearGradient(
                                              colors: [
                                                Colors.blueGrey,
                                                Colors.blueGrey
                                              ]));
                                    }
                                  : () {
                                      vote(e);
                                      Navigator.pop(context);
                                      Get.snackbar(
                                          'Вы проголосовали за вариант', e.text,
                                          snackPosition: SnackPosition.BOTTOM,
                                          barBlur: 0.0,
                                          backgroundGradient: LinearGradient(
                                              colors: [
                                                Colors.blueGrey,
                                                Colors.blueGrey
                                              ]));
                                    },
                              title: Text(e.text),
                              trailing: Text(e.amount.toString()),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future vote(Answer e) async {
    {
      User user = User.fromJson(box.read('user'));
      await VotingRepository().vote(user.id, e.id, widget.voting.id);
    }
  }
}
