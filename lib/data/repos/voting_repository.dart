import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/main.dart';

class VotingRepository {
  static final VotingRepository _singleton = VotingRepository._internal();

  factory VotingRepository() => _singleton;

  VotingRepository._internal();

  Future<List<Voting>> getAllVotings() async {
    Client client = Client();
    try {
      Response res = await client.get(ROOT_URL + '/votes');
      if (res.statusCode == 200) {
        return await parseTasks(res.bodyBytes);
      }
    } catch (e) {} finally {
      client.close();
    }
  }

  Future<List<Voting>> parseTasks(Uint8List responseBody) async {
    try {
      final parsed =
          json.decode(utf8.decode(responseBody)).cast<Map<String, dynamic>>();

      return parsed.map<Voting>((json) => Voting.fromJson(json)).toList();
    } catch (e) {}
    return null;
  }
}
