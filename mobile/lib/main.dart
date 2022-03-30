import 'package:flutter/material.dart';
import 'package:team_app/controller/team_controller.dart';
import 'package:unleash/unleash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  var unleash = await Unleash.init(
    UnleashSettings(
      appName: 'TeamApp',
      instanceId: 'sd6tpX8Y1s1VuqqhUdsK',
      unleashApi:
          Uri.parse('https://gitlab.com/api/v4/feature_flags/unleash/32359906'),
      apiToken: '',
    ),
  );
  print('Feature Flags: ${unleash.isEnabled('development')}');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TeamController());
    return GetMaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.deepPurple,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: const TextStyle(color: Colors.deepPurple),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  List<Widget> tabBarOptions = <Widget>[TeamPage(), ProfilePage()];
  var selectedTabIndex = 0.obs;

  HomePage({Key? key}) : super(key: key);

  void changeTab(int newTabIndex) {
    selectedTabIndex.value = newTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Center(
          child: tabBarOptions.elementAt(selectedTabIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Team',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedTabIndex.value,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: changeTab,
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              key: Key('avatar-image'),
              maxRadius: 50,
              backgroundImage: NetworkImage('https://placekitten.com/200/200'),
            ),
          ),
          Text('Ranu WP', style: Theme.of(context).textTheme.headline3),
          Text('ranu.wp@team.com',
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}

class TeamPage extends StatelessWidget {
  TeamController teamController = Get.find();

  TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (teamController.team != null) {
      return ExistTeamPage();
    }
    return WithoutTeamPage();
  }
}

class WithoutTeamPage extends StatelessWidget {
  WithoutTeamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: const Key('create-team-button'),
              child: const Text('Create Team'),
              onPressed: () async {
                Get.to(() => CreateTeamPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExistTeamPage extends StatelessWidget {
  TeamController teamController = Get.find();

  ExistTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teamController.team),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Invite your team using this code'),
          ],
        ),
      ),
    );
  }
}

class CreateTeamPage extends StatelessWidget {
  final teamNameTextEditingController = TextEditingController();
  TeamController teamController = Get.find();

  CreateTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Information'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: TextField(
                    key: const Key('team-name-text-field'),
                    decoration: const InputDecoration(
                      labelText: 'Team Name',
                    ),
                    controller: teamNameTextEditingController,
                  ),
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('create-team-button'),
                  child: const Text('Create Team'),
                  onPressed: () {
                    teamController.createTeam(teamNameTextEditingController.text);
                    Get.offAll(() => HomePage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
