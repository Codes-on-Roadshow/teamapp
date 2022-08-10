import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:teamapp/constants.dart';
import 'package:teamapp/data/models/team_model.dart';

class ApiService {
  Future<TeamModel?> addTeams(String name) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.teamsEndpoint);

      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'name': name}),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
