import 'package:get/get_state_manager/get_state_manager.dart';

class TeamController extends GetxController {
  dynamic team;

  void createTeam(String teamName) {
    team = teamName;
  }
}