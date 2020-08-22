// To parse this JSON data, do
//
//     final voting = votingFromJson(jsonString);

import 'dart:convert';

class Voting {
  Voting({
    this.id,
    this.name,
    this.description,
    this.dateCreated,
    this.dateClosed,
    this.answers,
  });

  int id;
  String name;
  String description;
  DateTime dateCreated;
  DateTime dateClosed;
  List<Answer> answers;

  factory Voting.fromRawJson(String str) => Voting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Voting.fromJson(Map<String, dynamic> json) => Voting(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateClosed: DateTime.parse(json["date_closed"]),
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "date_created": dateCreated.toIso8601String(),
        "date_closed": dateClosed.toIso8601String(),
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.id,
    this.text,
  });

  int id;
  String text;

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
