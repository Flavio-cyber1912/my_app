import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Per gestire il Navigation Rail

  void _onBottomNavigationBarTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FolderPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TimePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StarPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoCallPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
        foregroundColor: Colors.white,
        actions: [
          // Icona a destra nella AppBar
          IconButton(
            icon: Icon(Icons.apple, size: 40),
            onPressed: () {
              print("Icona notifiche cliccata!");
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              onTap: () {
                Navigator.pop(context); // Chiude il Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InboxPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.outbox),
              title: Text('Outbox'),
              onTap: () {
                Navigator.pop(context); // Chiude il Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OutboxPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context); // Chiude il Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              // Navigazione alle nuove pagine
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePageRail(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPageRail(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPageRail(),
                    ),
                  );
                  break;
              }
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: ListView.separated(
              itemCount: 6, // Numero di elementi nella lista
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1, // Spessore della linea
                  color: Colors.grey, // Colore della linea
                  indent: 16, // Margine a sinistra
                  endIndent: 16, // Margine a destra
                );
              },
              itemBuilder: (BuildContext context, int index) {
                // Dati per ogni elemento della lista
                final names = [
                  'Alejandro Ortega',
                  'Sophia Sacchi',
                  'Anna Russo',
                  'Silvia Petrone',
                  'Flavio Petrone',
                  'Michele Pacifico'
                ];
                final messages = [
                  '5 messages',
                  '7 messages',
                  '2 messages',
                  '9 messages',
                  '3 messages',
                  '4 messages'
                ];
                final initials = ['A', 'S', 'R', 'S', 'F', 'M'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      initials[index], // Lettera dell'avatar
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Sfondo dell'avatar
                  ),
                  title: Text(names[index]), // Nome
                  subtitle: Text(messages[index]), // Numero di messaggi
                  trailing: Icon(Icons.message, color: Colors.deepPurple),
                  onTap: () {
                    // Azione al tocco della ListTile
                    print('Tapped on ${names[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icona con Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.folder, size: 30),
                  onPressed: () => _onBottomNavigationBarTapped(0),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '16', // Numero del badge
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.access_time, size: 30),
              onPressed: () => _onBottomNavigationBarTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.star, size: 30),
              onPressed: () => _onBottomNavigationBarTapped(2),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.video_call, size: 30),
                  onPressed: () => _onBottomNavigationBarTapped(3),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1', // Numero del badge
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Nuove pagine per la Navigation Rail
class HomePageRail extends StatelessWidget {
  const HomePageRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(child: Text('Pagina Home della Navigation Rail')),
    );
  }
}

class SearchPageRail extends StatelessWidget {
  const SearchPageRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Page')),
      body: const Center(child: Text('Pagina Search della Navigation Rail')),
    );
  }
}

class SettingsPageRail extends StatelessWidget {
  const SettingsPageRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),
      body: const Center(child: Text('Pagina Settings della Navigation Rail')),
    );
  }
}

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: const Center(child: Text('Pagina Inbox')),
    );
  }
}

class OutboxPage extends StatelessWidget {
  const OutboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outbox')),
      body: const Center(child: Text('Pagina Outbox')),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Pagina Favorites')),
    );
  }
}

// Nuove pagine per la BottomNavigationBar
class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folder Page')),
      body:
          const Center(child: Text('Pagina Folder della BottomNavigationBar')),
    );
  }
}

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Page')),
      body: const Center(child: Text('Pagina Time della BottomNavigationBar')),
    );
  }
}

class StarPage extends StatelessWidget {
  const StarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Star Page')),
      body: const Center(child: Text('Pagina Star della BottomNavigationBar')),
    );
  }
}

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call Page')),
      body: const Center(
          child: Text('Pagina Video Call della BottomNavigationBar')),
    );
  }
}
