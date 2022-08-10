import 'dart:convert';

List<TeamModel> teamModelFromJson(String str) => List<TeamModel>.from(jsonDecode(str).map((x) => TeamModel.fromJson(x)));

String teamModelToJson(List<TeamModel> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamModel {
    TeamModel({
        required this.name,
    });

    String name;

    factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
