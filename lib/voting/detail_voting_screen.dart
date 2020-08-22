import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jkh/data/models/voting.dart';

class VotingDetailsPage extends StatefulWidget {
  VotingDetailsPage({Key key, this.voting}) : super(key: key);
  final Voting voting;
  @override
  _VotingDetailsPageState createState() => _VotingDetailsPageState();
}

class _VotingDetailsPageState extends State<VotingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.voting.name,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            Text(
              widget.voting.description,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            Column(
              children: widget.voting.answers
                  .map((e) => Card(
                        child: ListTile(
                          onTap: () {
                            // Navigator.pop(context);
                            Get.close(1);
                            Get.snackbar('Вы проголосовали за вариант', e.text,
                                snackPosition: SnackPosition.BOTTOM,
                                barBlur: 0.0,
                                backgroundGradient: LinearGradient(colors: [
                                  Colors.blueGrey,
                                  Colors.blueGrey
                                ]));
                          },
                          title: Text(e.text),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
