import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF461D7C), // LSU Purple
          primary: const Color(0xFF461D7C),
          secondary: const Color(0xFFFDD023), // LSU Gold
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF461D7C),
          foregroundColor: Colors.white, // For text and icons
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF461D7C),
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MainLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 1});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const MapScreen(),
    const HomeScreen(),
    const HelpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      child: _screens[_selectedIndex],
    );
  }
}

// Screen Widgets
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentFloor = 1;
  final List<String> _floorImages = [
    '1stfloor.jpg',
    '2ndfloor.jpg',
    '3rdfloor.jpg',
  ];

  void _nextFloor() {
    setState(() {
      if (_currentFloor < 3) {
        _currentFloor++;
      }
    });
  }

  void _previousFloor() {
    setState(() {
      if (_currentFloor > 1) {
        _currentFloor--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              _floorImages[_currentFloor - 1],
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentFloor > 1 ? _previousFloor : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF461D7C),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Previous Floor'),
                ),
                Text(
                  'Floor $_currentFloor',
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: _currentFloor < 3 ? _nextFloor : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF461D7C),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next Floor'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstructionsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Instructions',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirstFloorScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'First Floor',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondFloorScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Second Floor',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdFloorScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Third Floor',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Center(
              child: Text("We're here to help", style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),

            // Search bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search for help...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                // Optional: implement keyword search within your help content
              },
            ),
            const SizedBox(height: 20),

            // FAQ Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to FAQ screen or show dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('FAQ'),
                        content: const Text(
                          'Q: How do I use the app?\nA: Here’s how...',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.question_answer),
              label: const Text('FAQ'),
            ),
            const SizedBox(height: 10),
            // Leave a Rating
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const RatingSheet();
                  },
                );
              },
              icon: const Icon(Icons.star_rate),
              label: const Text('Leave a Rating'),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TutorialVideoScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_fill),
              label: const Text('Watch Tutorial Video'),
            ),
            // Report a Bug
            ElevatedButton.icon(
              onPressed: () {
                // Replace with your bug report logic or URL
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Report a Bug'),
                        content: const Text(
                          'Please email support@yourapp.com with a description of the bug.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.bug_report),
              label: const Text('Report a Bug'),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialVideoScreen extends StatefulWidget {
  const TutorialVideoScreen({super.key});

  @override
  State<TutorialVideoScreen> createState() => _TutorialVideoScreenState();
}

class _TutorialVideoScreenState extends State<TutorialVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/tutorial.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh when loaded
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorial Video')),
      body: Center(
        child:
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class RatingSheet extends StatefulWidget {
  const RatingSheet({super.key});

  @override
  State<RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<RatingSheet> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Rate our app!', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Save or send rating somewhere
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Thanks for rating us $_rating stars!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class FirstFloorScreen extends StatelessWidget {
  const FirstFloorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1, // Home tab
      onItemTapped: (index) {
        if (index != 1) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: index),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('First Floor')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => QuestionScreen(questionNumber: i),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF461D7C),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  final int questionNumber;

  const QuestionScreen({super.key, required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      onItemTapped: (index) {
        if (index != 1) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: index),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Question $questionNumber')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'This is a placeholder for Question $questionNumber',
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF461D7C),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondFloorScreen extends StatelessWidget {
  const SecondFloorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      onItemTapped: (index) {
        if (index != 1) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: index),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Second Floor')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => QuestionScreen(questionNumber: i),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF461D7C),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThirdFloorScreen extends StatelessWidget {
  const ThirdFloorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      onItemTapped: (index) {
        if (index != 1) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: index),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Third Floor')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => QuestionScreen(questionNumber: i),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF461D7C),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      onItemTapped: (index) {
        if (index != 1) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: index),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Instructions')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to the Scavenger Hunt!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'How to Play:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Select a floor from the home screen',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Choose a question from that floor',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. Use the map to find the location mentioned in the question',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. Visit the location and look for information to answer the question',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Need Help?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Use the map screen to navigate between floors and find locations',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Visit the help screen if you get stuck or need assistance',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Good Luck!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
