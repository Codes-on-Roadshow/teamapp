import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:teamapp/api_service.dart';
import 'package:teamapp/controller/team_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    const GoogleProviderConfiguration(
        clientId:
            '302449687825-t17efb2unjes03tv6832rk6o13esg0n0.apps.googleusercontent.com'),
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TeamController());
    return GetMaterialApp(
      home: const AuthGate(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        highlightColor: Colors.deepPurple.shade300,
        indicatorColor: Colors.amber,
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

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: false,
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network('https://i.ibb.co/C5v8m0y/team-app.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('Welcome to TeamApp! Please sign in to continue.'),
              );
            },
          );
        }

        return HomePage();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Widget> tabBarOptions = <Widget>[TeamPage(), ProfilePage()];
  final selectedTabIndex = 0.obs;

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
  ProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: UserAvatar(
              key: const Key('avatar-image'),
              auth: auth,
            ),
          ),
          Text(auth.currentUser?.displayName ?? '',
              style: Theme.of(context).textTheme.headline4),
          Text(auth.currentUser?.email ?? '',
              style: Theme.of(context).textTheme.headline5),
          ElevatedButton(
            key: const Key('sign-out-button'),
            child: const Text('Sign Out'),
            onPressed: () async {
              await FlutterFireUIAuth.signOut();
              Get.offAll(() => const AuthGate());
            },
          ),
        ],
      ),
    );
  }
}

class TeamPage extends StatelessWidget {
  final TeamController teamController = Get.find();

  TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (teamController.team != null) {
      return ExistTeamPage();
    }
    return const WithoutTeamPage();
  }
}

class WithoutTeamPage extends StatelessWidget {
  const WithoutTeamPage({
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
  final TeamController teamController = Get.find();

  ExistTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Member"),
              Tab(text: "Active Pair"),
              Tab(text: "Pair History"),
            ],
          ),
          title: Text(teamController.team),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Invite your team using this code'),
                ],
              ),
            ),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

void _addTeam(String name) async {
  (await ApiService().addTeams(name));
}

class CreateTeamPage extends StatelessWidget {
  final teamNameTextEditingController = TextEditingController();
  final TeamController teamController = Get.find();

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
                    String name = teamNameTextEditingController.text;
                    _addTeam(name);
                    teamController.createTeam(name);
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
