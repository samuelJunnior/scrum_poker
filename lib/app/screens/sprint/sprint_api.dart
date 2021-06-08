import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';
import 'package:scrum_poker/app/shared/util/constants.dart';

class SprintApi {
  final Client _client;
  SprintApi(this._client);

  Future<List<Sprint>> fetchSprints() async {
    final response =
        await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> jPosts = json.decode(response.body);
      final sprints = jPosts.map((jp) => Sprint.fromJson(jp)).toList();
      return sprints;
    } else {
      throw Exception('Erro ao recuperar as sprints');
    }
  }

  Future<bool> adicionarSprint(Sprint sprint) async {
    final response = await _client.post(
      Uri.parse('${Constants.API_BASE_URL}/sprint'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(sprint),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Erro ao salvar a sprint: ${response.statusCode}');
    }
  }

  Future deletarSprint(int idSprint) async {
    final response = await _client
        .delete(Uri.parse('${Constants.API_BASE_URL}/sprint/$idSprint'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Erro ao deletar a sprint: ${response.statusCode}');
    }
  }
}
