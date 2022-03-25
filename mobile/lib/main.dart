import 'package:flutter/material.dart';
import 'package:unleash/unleash.dart';

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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyStatefulWidget(),
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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TeamPage(),
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
