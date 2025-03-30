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
                            'Q: What is this app?\n'
                            '   A: It is a scavenger hunt centered app that focuses on exploring\n'
                            '   Louisiana\'s State University Patrick F. Taylor Building.\n'
                            'Q: How do I start the game?\n'
                            '   A: To start just pick a floor and question based on the picture or question\n'
                            '   go around the building and select the answer you believe is correct.\n'
                            'Q: How do I use the app?\n'
                            '   A: To return to the find where you are select the Maps button in the\n'
                            '   navigation bar below.\n'
                            '   To answer see the questions based on the floor, you have to answer select\n'
                            '   the Home Button.\n'
                            '   To see get help in other areas select the Help button.\n'
                            'Q: How long should I wait for a reported bug to be fixed?\n'
                            '   A: Our team will address any bugs reported within 24HRS.\n'
                            'Q: How do I make a suggestion?\n'
                            '   A: All suggestion can be made throught the same process as reporting a bug.\n'
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Center(
              child: Text(
                "We're here to help",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: "Proximanova",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
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

            // FAQ Button
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
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 0,
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
                          builder: (context) => QuestionScreen(
                            questionNumber: i,
                            floor: 0,
                            onCorrectAnswer: () => markQuestionAsCompleted(i),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: completedQuestions[i - 1]
                          ? const Color(0xFFFDD023)
                          : const Color(0xFF461D7C),
                      foregroundColor: completedQuestions[i - 1]
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


class QuestionScreen extends StatefulWidget {
  final List<List<String>> tableData = const [
    ["In what room are the Bengal Bots in?", "What is the name of the group of which this symbol belongs?", "Can you purchase monster energy drinks on this floor?",
      "In what room is the Fanuc Robatic Arm?","In what floor can you purchase bluebooks?"],
    ["What is the room number that contains the Among Us artwork on a whiteboard?", "What room contains the MMR machine?","What is the name of the LSU Mascot?"],
    ["Which floor can the wall of trophies be found?", "What is the office number that contains the model airplane?", "Which room number has this funny chart placed on its door?","Which is the full name of this coil?"],
  ];
  final List<List<String>> pictureData = const [
    ['weirdchartUNSURE.jpeg', 'BetaSign.jpeg','EnergyDrinks.jpeg','RoboaticArm.jpeg','BlueBook.png'],
    ['AmungUs.jpeg','MMRmachine.jpeg', 'LSUtiger.png'],
    ['Trophies.jpeg', 'airplane.jpeg','UnknownChart.jpeg','teslacoil_farview.jpeg']
  ];
  final List<List<String>> answers = const [
    ["1344", "Tau Beta Pi", "All of Them", "1300","1st Floor"],
    ["2317", "2348","Mike"],
    ["3rd Floor", "3261", "3316","Musical Tesla Coil"]
  ];


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
  _QuestionScreenState createState() => _QuestionScreenState();
}


class _QuestionScreenState extends State<QuestionScreen> {
  String? selectedAnswer;
  late ConfettiController _confettiController;
  bool isCorrect = false;


  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }


  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }


  List<List<String>> firstFloorChoices = [
    //1stQ
    ["1344","1378","1200","1201"],
    ["Beta Pi","Pi Beta Tau","Tau Beta Pi","Tau Beta"],
    ["1st Floor","2nd Floor","3rd Floor","All of Them"],
    ["1344","1300","1200","1100"],
    ["1st Floor","2nd Floor","3rd Floor","All of Them"]
  ];
  List<List<String>> secondFloorChoices = [
    //2stQ
    ["2317","2371","2300","2902"],
    ["2348","2370","2150","2349"],
    ["Mike","Micheal","Nick","Tigers"]
  ];
  List<List<String>> thirdFloorChoices = [
    //3stQ
    ["1st Floor","2nd Floor","3rd Floor","All of Them"],
    ["3260","3261","3289","3301"],
    ["3400","3261","3260","3316"],
    ["Tesla Coil","Electromagnetic Coil LSU","Musical Tesla Coil","Prototype Tesla Coil"]];




  void checkAnswer(String answer, String correct) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == correct;
    });


    if (isCorrect) {
      _confettiController.play();
      widget.onCorrectAnswer(); // Call the callback when answer is correct
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Oops! Try Again."))
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    List<List<String>> flooranswers = firstFloorChoices;
    if(widget.floor == 0){
      flooranswers = firstFloorChoices;
    }else if(widget.floor == 1){
      flooranswers = secondFloorChoices;
    }else if(widget.floor == 2){
      flooranswers = thirdFloorChoices;
    }
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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF461D7C), width: 5)
                        ),
                        child: Image(image: AssetImage(widget.pictureData[widget.floor][(widget.questionNumber-1)]),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Text(
                      widget.tableData[widget.floor][(widget.questionNumber-1)],
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    for (int i = 0; i < 4; i++) ...[
                      ElevatedButton(
                        onPressed: () {
                          checkAnswer(
                              flooranswers[(widget.questionNumber-1)][i],
                              widget.answers[(widget.floor)][(widget.questionNumber-1)]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedAnswer == flooranswers[(widget.questionNumber-1)][i]
                              ? (isCorrect ? Colors.green : Colors.red)
                              : const Color(0xFF461D7C),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          flooranswers[(widget.questionNumber-1)][i],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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
  List<bool> completedQuestions = List.generate(3, (index) => false);


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
        appBar: AppBar(title: const Text('Second Floor')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 3; i++) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionScreen(
                            questionNumber: i,
                            floor: 1,
                            onCorrectAnswer: () => markQuestionAsCompleted(i),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: completedQuestions[i - 1]
                          ? const Color(0xFFFDD023)
                          : const Color(0xFF461D7C),
                      foregroundColor: completedQuestions[i - 1]
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
  List<bool> completedQuestions = List.generate(4, (index) => false);


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
        appBar: AppBar(title: const Text('Third Floor')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 4; i++) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionScreen(
                            questionNumber: i,
                            floor: 2,
                            onCorrectAnswer: () => markQuestionAsCompleted(i),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: completedQuestions[i - 1]
                          ? const Color(0xFFFDD023)
                          : const Color(0xFF461D7C),
                      foregroundColor: completedQuestions[i - 1]
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

