import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' show pi;
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
          foregroundColor: Color(0xFFFDD023), // For text and icons
          titleTextStyle: TextStyle(
            fontFamily: 'Proximanova',
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Color(0xFFFDD023),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF461D7C),
          unselectedItemColor: Colors.grey,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Proximanova',
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Proximanova',
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Proximanova',
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Proximanova',
            fontWeight: FontWeight.w800,
          ),
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
      backgroundColor: const Color(0xFFF1EED8),
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
                    foregroundColor: const Color(0xFFFDD023),
                  ),
                  child: const Text(
                    'Previous Floor',
                    style: TextStyle(
                      fontFamily: 'Proximanova',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Floor $_currentFloor',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proximanova',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: _currentFloor < 3 ? _nextFloor : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF461D7C),
                    foregroundColor: const Color(0xFFFDD023),
                  ),
                  child: const Text(
                    'Next Floor',
                    style: TextStyle(
                      fontFamily: 'Proximanova',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
      backgroundColor: const Color(0xFFF1EED8),
      appBar: AppBar(title: const Text('LSU Scavenger Hunt')),
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
                  foregroundColor: const Color(0xFFFDD023),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proximanova',
                    fontWeight: FontWeight.w600,
                  ),
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
                  foregroundColor: const Color(0xFFFDD023),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'First Floor',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proximanova',
                    fontWeight: FontWeight.w600,
                  ),
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
                  foregroundColor: const Color(0xFFFDD023),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Second Floor',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proximanova',
                    fontWeight: FontWeight.w600,
                  ),
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
                  foregroundColor: const Color(0xFFFDD023),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Third Floor',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Proximanova',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpButtonData {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  HelpButtonData({
    required this.label,
    required this.icon,
    required this.onPressed,
  });
}

List<HelpButtonData> _helpButtons(BuildContext context) {
  return [
    HelpButtonData(
      label: 'FAQ',
      icon: Icons.question_answer,
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('FAQ'),
                content: const Text(
                  'Q: How do I use the app?\nA: Use the map page and question guidance to navigate the PFT and complete the questions!\nQ: I\'m feeling stuck on how to use the app. What should I do?\nA: Check out the tutorial video or email antoinekaleb6@gmail.com for help. \nQ: How do I report a bug?\nA: Email antoinekaleb6@gmail.com with a description of the bug. ',
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
    ),
    HelpButtonData(
      label: 'Leave a Rating',
      icon: Icons.star_rate,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const RatingSheet(),
        );
      },
    ),
    HelpButtonData(
      label: 'Watch Tutorial',
      icon: Icons.play_circle_fill,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TutorialVideoDialog()),
        );
      },
    ),
    HelpButtonData(
      label: 'Report a Bug',
      icon: Icons.bug_report,
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Report a Bug'),
                content: const Text(
                  'Please email antoinekaleb6@gmail.com with a description of the bug.',
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
    ),
  ];
}

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController searchController = TextEditingController();
  List<HelpButtonData> allButtons = [];
  List<HelpButtonData> filteredButtons = [];

  @override
  void initState() {
    super.initState();
    allButtons = _helpButtons(context);
    filteredButtons = List.from(allButtons);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredButtons =
          allButtons
              .where((button) => button.label.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EED8),
      appBar: AppBar(title: const Text('Help Center')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "We're here to help",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Proximanova",
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD29F13),
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // Search bar
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search for help...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Help Buttons
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                children: [
                  for (var buttonData in filteredButtons)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 120,
                      child: ElevatedButton.icon(
                        onPressed: buttonData.onPressed,
                        icon: Icon(buttonData.icon, size: 28),
                        label: Text(
                          buttonData.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Proximanova',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Color(0xFF461D7C),
                          foregroundColor: Color(0xFFFDD023),
                          elevation: 20,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class TutorialVideoDialog extends StatefulWidget {
  const TutorialVideoDialog({super.key});

  @override
  State<TutorialVideoDialog> createState() => _TutorialVideoDialogState();
}

class _TutorialVideoDialogState extends State<TutorialVideoDialog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://raw.githubusercontent.com/loraavie/branded_tour_app/bcea1741a540b5f914922875adb244192c15e56e/assets/lsuapptutorial.mp4',
      )
      ..initialize().then((_) {
        setState(() {}); // update the UI when video is ready
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
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 250,
        child:
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                : const Center(child: CircularProgressIndicator()),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
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

class FirstFloorScreen extends StatefulWidget {
  const FirstFloorScreen({super.key});

  @override
  State<FirstFloorScreen> createState() => _FirstFloorScreenState();
}

class _FirstFloorScreenState extends State<FirstFloorScreen> {
  List<bool> completedQuestions = List.generate(5, (index) => false);

  void markQuestionAsCompleted(int questionNumber) {
    setState(() {
      completedQuestions[questionNumber - 1] = true;
    });
  }

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
        backgroundColor: const Color(0xFFF1EED8),
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
                              (context) => QuestionScreen(
                                questionNumber: i,
                                floor: 1,
                                onCorrectAnswer:
                                    () => markQuestionAsCompleted(i),
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFFFDD023)
                              : const Color(0xFF461D7C),
                      foregroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFF461D7C)
                              : const Color(0xFFFDD023),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Proximanova',
                        fontWeight: FontWeight.w600,
                      ),
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

class QuestionData {
  final String question;
  final String imagePath;
  final List<String> options;
  final int correctAnswer;

  const QuestionData({
    required this.question,
    required this.imagePath,
    required this.options,
    required this.correctAnswer,
  });
}

final Map<String, QuestionData> questions = {
  // First Floor Questions
  '1_1': QuestionData(
    question:
        'Make your way to this location under the stairs to the second floor. What does the sticker on the floor say? ',
    imagePath: 'StairsUnknown.jpeg',
    options: [
      'Geaux Tigers',
      'Geaux Communicate',
      'Great Communication',
      'Geaux Engineering',
    ],
    correctAnswer: 1,
  ),
  '1_2': QuestionData(
    question:
        'What item cannot be found in one of the vending machines on the first floor?',
    imagePath: 'EnergyDrinks.jpeg',
    options: ['Monster Energy', 'Scantrons', 'Snickers', 'Pepsi'],
    correctAnswer: 3,
  ),
  '1_3': QuestionData(
    question:
        'This statue can be found near the center of the first floor of the PFT. What organization does it represent?',
    imagePath: 'BetaSign.jpeg',
    options: [
      'Tau Beta Pi',
      'Collegiate Professional Engineers',
      'Society of Software Engineers',
      'Pi Delta Phi',
    ],
    correctAnswer: 0,
  ),
  '1_4': QuestionData(
    question:
        'Locate this sign on the first floor of the PFT. What student group does it represent?',
    imagePath: 'weirdchartUNSURE.jpeg',
    options: ['Tiger Bots', 'Bengal Builds', 'Tiger Tech', 'Bengal Bots'],
    correctAnswer: 3,
  ),
  '1_5': QuestionData(
    question:
        'This robot is located in one of the glass-enclosed classrooms on the first floor of the PFT. What is the room number?',
    imagePath: 'IMG_0470.jpeg',
    options: ['Room 1100', 'Room 1200', 'Room 1300', 'Room 1400'],
    correctAnswer: 2,
  ),

  // Add more questions for first floor...

  // Second Floor Questions
  '2_1': QuestionData(
    question:
        'Locate the one lab that is on both the first and second floor. What does it contain?',
    imagePath: 'discolumn.webp',
    options: [
      'Distillation Columns',
      'Hadron Collider',
      'Hydraulic Press',
      'Chemical Storage Columns',
    ],
    correctAnswer: 0,
  ),
  '2_2': QuestionData(
    question: 'Where on the second floor can you find this car?',
    imagePath: 'car.webp',
    options: ['2210', '2214', '2215', '2224'],
    correctAnswer: 1,
  ),
  '2_3': QuestionData(
    question:
        'This drawing is located in one of the rooms on the second floor of PFT. What is the room number?',
    imagePath: 'AmungUs.jpeg',
    options: ['Room 2214', 'Room 2317', 'Room 2412', 'Room 2110'],
    correctAnswer: 1,
  ),
  '2_4': QuestionData(
    question:
        'What is the name of this machine located on the second floor of PFT?',
    imagePath: 'MMRmachine.jpeg',
    options: [
      'The IEC Machine',
      'The MRNA Machine',
      'The NRA Machine',
      'The MMR Machine',
    ],
    correctAnswer: 3,
  ),
  '2_5': QuestionData(
    question:
        'What is the name of the lab that features a black car for driving simulations?',
    imagePath: '',
    options: [
      'Civil Engineering Driving Simulator Lab',
      'Transportation Engineering Simulation Center',
      'Civil Engineering Vehicle Simulation Lab',
      'Civil Systems Driving Research Lab',
    ],
    correctAnswer: 0,
  ),

  // Add more questions for second floor...

  // Third Floor Questions
  '3_1': QuestionData(
    question: 'Which one of these is a trophy contained in this trophy case?',
    imagePath: 'Trophies.jpeg',
    options: [
      'Engineering Athletes Trophy',
      'Extreme Physics Trophy',
      'Canoe Racing Trophy',
      'Engineering Olympiad Trophy',
    ],
    correctAnswer: 2,
  ),
  '3_2': QuestionData(
    question: 'What room on the third floor can this plane be found in?',
    imagePath: 'airplane.jpeg',
    options: ['3261', '3360', '3100', '3224'],
    correctAnswer: 0,
  ),
  '3_3': QuestionData(
    question:
        'What is the name of the large copper colored device in this image?',
    imagePath: 'teslacoil_farview.jpeg',
    options: [
      'Student Engineering Experience',
      'Tesla Coil Lab',
      'Experimental Tesla Coil',
      'Musical Tesla Coil',
    ],
    correctAnswer: 3,
  ),
  '3_4': QuestionData(
    question:
        'How many stairwells on the third floor lead to the fourth floor?',
    imagePath: 'lsulogo.png',
    options: ['None', '1', '2', '3'],
    correctAnswer: 1,
  ),
  '3_5': QuestionData(
    question:
        'Which one of these professors have an office on the third floor of the PFT?',
    imagePath: 'lsulogo.png',
    options: [
      'Harmut Kaiser',
      'Rahul Shah',
      'Golden Richard III',
      'David Bowles',
    ],
    correctAnswer: 1,
  ),

  // Add more questions for third floor...
};

class QuestionScreen extends StatefulWidget {
  final int questionNumber;
  final int floor;
  final VoidCallback onCorrectAnswer;

  const QuestionScreen({
    super.key,
    required this.questionNumber,
    required this.floor,
    required this.onCorrectAnswer,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int? selectedAnswer;
  bool showFeedback = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  QuestionData get questionData {
    final key = '${widget.floor}_${widget.questionNumber}';
    return questions[key] ??
        QuestionData(
          question: 'Question not found',
          imagePath: 'assets/placeholder.jpg',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctAnswer: 0,
        );
  }

  void _handleAnswerSelection(int answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
    });

    if (answer == questionData.correctAnswer) {
      widget.onCorrectAnswer();
      _confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainLayout(
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
            appBar: AppBar(title: Text('Question ${widget.questionNumber}')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Text
                  Text(
                    questionData.question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Proximanova',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF461D7C),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        questionData.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Multiple Choice Answers
                  const Text(
                    'Select your answer:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Proximanova',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF461D7C),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Answer Options
                  for (int i = 0; i < questionData.options.length; i++) ...[
                    ElevatedButton(
                      onPressed:
                          showFeedback ? null : () => _handleAnswerSelection(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            showFeedback
                                ? (i == questionData.correctAnswer
                                    ? Colors.green.withOpacity(0.2)
                                    : (i == selectedAnswer
                                        ? Colors.red.withOpacity(0.2)
                                        : Colors.white))
                                : Colors.white,
                        foregroundColor: const Color(0xFF461D7C),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color:
                                showFeedback
                                    ? (i == questionData.correctAnswer
                                        ? Colors.green
                                        : (i == selectedAnswer
                                            ? Colors.red
                                            : const Color(0xFF461D7C)))
                                    : const Color(0xFF461D7C),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        questionData.options[i],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Proximanova',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],

                  if (showFeedback) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            selectedAnswer == questionData.correctAnswer
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              selectedAnswer == questionData.correctAnswer
                                  ? Colors.green
                                  : Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            selectedAnswer == questionData.correctAnswer
                                ? Icons.check_circle
                                : Icons.cancel,
                            color:
                                selectedAnswer == questionData.correctAnswer
                                    ? Colors.green
                                    : Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            selectedAnswer == questionData.correctAnswer
                                ? 'Correct! Well done!'
                                : 'Incorrect. Try again!',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Proximanova',
                              fontWeight: FontWeight.w600,
                              color:
                                  selectedAnswer == questionData.correctAnswer
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Back Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF461D7C),
                        foregroundColor: const Color(0xFFFDD023),
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontFamily: 'Proximanova',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 1,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Color(0xFF461D7C), // LSU Purple
              Color(0xFFFDD023), // LSU Gold
            ],
          ),
        ),
      ],
    );
  }
}

class SecondFloorScreen extends StatefulWidget {
  const SecondFloorScreen({super.key});

  @override
  State<SecondFloorScreen> createState() => _SecondFloorScreenState();
}

class _SecondFloorScreenState extends State<SecondFloorScreen> {
  List<bool> completedQuestions = List.generate(5, (index) => false);

  void markQuestionAsCompleted(int questionNumber) {
    setState(() {
      completedQuestions[questionNumber - 1] = true;
    });
  }

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
        backgroundColor: const Color(0xFFF1EED8),
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
                              (context) => QuestionScreen(
                                questionNumber: i,
                                floor: 2,
                                onCorrectAnswer:
                                    () => markQuestionAsCompleted(i),
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFFFDD023)
                              : const Color(0xFF461D7C),
                      foregroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFF461D7C)
                              : const Color(0xFFFDD023),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Proximanova',
                        fontWeight: FontWeight.w600,
                      ),
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

class ThirdFloorScreen extends StatefulWidget {
  const ThirdFloorScreen({super.key});

  @override
  State<ThirdFloorScreen> createState() => _ThirdFloorScreenState();
}

class _ThirdFloorScreenState extends State<ThirdFloorScreen> {
  List<bool> completedQuestions = List.generate(5, (index) => false);

  void markQuestionAsCompleted(int questionNumber) {
    setState(() {
      completedQuestions[questionNumber - 1] = true;
    });
  }

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
        backgroundColor: const Color(0xFFF1EED8),
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
                              (context) => QuestionScreen(
                                questionNumber: i,
                                floor: 3,
                                onCorrectAnswer:
                                    () => markQuestionAsCompleted(i),
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFFFDD023)
                              : const Color(0xFF461D7C),
                      foregroundColor:
                          completedQuestions[i - 1]
                              ? const Color(0xFF461D7C)
                              : const Color(0xFFFDD023),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Question $i',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Proximanova',
                        fontWeight: FontWeight.w600,
                      ),
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
        backgroundColor: const Color(0xFFF1EED8),
        appBar: AppBar(title: const Text('Instructions')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to the LSU Scavenger Hunt!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'How to Play:',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Select a floor of Patrick F. Taylor Hall to explore',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Choose a question from that floor',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. Find the location mentioned in the question',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. Visit the location and look for information to answer the question',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Need Help?',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Use the map screen to navigate between floors and find locations',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Visit the help screen if you get stuck or need assistance',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF461D7C),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Good Luck and Geaux Tigers!',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Proximanova',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF461D7C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
