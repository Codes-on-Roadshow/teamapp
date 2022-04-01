import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:teamapp/controller/team_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to TeamApp! Please sign in to continue.'
                      : 'Welcome to TeamApp! Please create an account to continue',
                ),
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
  ProfilePage({Key? key}) : super(key: key);
  //final FirebaseAuth auth = FirebaseAuth.instance;
  var auth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.all(16.0),
              // child: UserAvatar(
              //   key: const Key('avatar-image'),
              //   auth: auth,
              // ),
              child: CircleAvatar(
                key: Key('avatar-image'),
                maxRadius: 50,
                backgroundImage:
                    NetworkImage('https://placekitten.com/200/200'),
              )),
          Text(auth?.currentUser?.displayName ?? 'Ranu WP',
              style: Theme.of(context).textTheme.headline3),
          Text(auth?.currentUser?.email ?? 'ranu.wp@team.com',
              style: Theme.of(context).textTheme.headline5),
          ElevatedButton(
            key: const Key('sign-out-button'),
            child: const Text('Sign Out'),
            onPressed: () async {
              await FlutterFireUIAuth.signOut(
                context: context,
                auth: auth,
              );
              Get.offAll(() => const AuthGate());
            },
          ),
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
                    teamController
                        .createTeam(teamNameTextEditingController.text);
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
