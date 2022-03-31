import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:unleash/unleash.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return MaterialApp(
      home: const MyStatefulWidget(),
      // home: const AuthGate(),
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

        return const MyStatefulWidget();
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const TeamPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
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
              style: Theme.of(context).textTheme.headline3),
          Text(auth.currentUser?.email ?? '',
              style: Theme.of(context).textTheme.headline5),
          ElevatedButton(
            key: const Key('sign-out-button'),
            child: const Text('Sign Out'),
            onPressed: () => FlutterFireUIAuth.signOut(
              context: context,
              auth: auth,
            ),
          ),
        ],
      ),
    );
  }
}

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TeamPageState();
  }
}

class _TeamPageState extends State<TeamPage> {
  dynamic _team;

  void _createTeam(String teamName) {
    setState(() {
      _team = teamName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_team != null) {
      return ExistTeamPage(team: _team);
    }
    return WithoutTeamPage(createTeam: _createTeam);
  }
}

class WithoutTeamPage extends StatefulWidget {
  final Function(String teamName) createTeam;

  const WithoutTeamPage({
    Key? key,
    required this.createTeam,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WithoutTeamPageState();
  }
}

class _WithoutTeamPageState extends State<WithoutTeamPage> {
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
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTeamPage(),
                  ),
                );
                widget.createTeam(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExistTeamPage extends StatelessWidget {
  final String team;

  const ExistTeamPage({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team),
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
  final teamNameController = TextEditingController();

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
                    controller: teamNameController,
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
                    Navigator.pop(context, teamNameController.text);
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
