import 'dart:convert';
import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:jkh/data/models/voting.dart';
import 'package:jkh/main.dart';

class VotingRepository {
  static final VotingRepository _singleton = VotingRepository._internal();

  factory VotingRepository() => _singleton;

  VotingRepository._internal();
  GetStorage box = GetStorage();

  Future<String> vote(int user, int answer, int voting) async {
    Client client = Client();
    try {
      Response res = await client.post(ROOT_URL + '/votes/vote',
          body: {"user": user.toString(), "answer": answer.toString()});
      if (res.statusCode == 200) {
        box.write(voting.toString(), answer);
        return "ok";
      }
    } catch (e) {
      return "error";
    } finally {
      client.close();
    }
    return "error";
  }

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
