import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'package:animated_text_kit/animated_text_kit.dart';
import 'signup_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _fullText = "Welcome to Finance Tracker!";
  String _displayedText = ""; // This will hold the partially typed text
  late Timer _timer;

  // Function to simulate the typing effect
  void _startTypingEffect() {
    int _currentIndex = 0;
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _displayedText = _fullText.substring(0, _currentIndex);
      });
      _currentIndex++;
      if (_currentIndex > _fullText.length) {
        _timer.cancel(); // Stop the typing animation once it's complete
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTypingEffect(); // Start typing animation as soon as the screen loads
  }

  @override
  void dispose() {
    _timer.cancel(); // Clean up the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 24.0), // Adjust padding as needed
            alignment: Alignment.centerLeft, // Align text to the right
            child: Text(
              'Lava Devilu',
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Typing Animation
          Center(
            child: SizedBox(
              width: 470,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome to your Finance Tracker !',
                    textStyle: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                    speed: Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
          SizedBox(height: 50),
          // Login Button
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginScreen()),
              // );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50), // Button dimensions
            ),
            child: Text('Login'),
          ),
          SizedBox(height: 20),
          // Signup Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50), // Button dimensions
            ),
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
