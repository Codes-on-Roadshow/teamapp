import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyStatefulWidget(),
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 129, 50, 194),
          buttonTheme: const ButtonThemeData(
              buttonColor: Color.fromARGB(255, 129, 50, 194))),
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

class _WithoutTeamPageState extends State<WithoutTeamPage>{
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

  const ExistTeamPage({Key? key, required this.team }) : super(key: key);

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
  String _teamName = '';

  CreateTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('papapa'),
            TextField(
              key: const Key('team-name-text-field'),
              decoration: const InputDecoration(
                labelText: 'Team Name',
              ),
              onChanged: (String teamName) {
                _teamName = teamName;
              },
            ),
            ElevatedButton(
              key: const Key('create-team-button'),
              child: const Text('Create Team'),
              onPressed: () {
                Navigator.pop(context, _teamName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
