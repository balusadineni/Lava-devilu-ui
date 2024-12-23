import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Adjust the path according to your project structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        brightness: Brightness.dark, // Set the brightness to dark
        primaryColor: Colors.blueGrey, // Customize primary color if needed
        scaffoldBackgroundColor:
            Colors.black, // Dark background for the entire app
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87, // Dark color for AppBar
          foregroundColor: Colors.white, // White text on AppBar
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white), // Default text color for body text
          bodyMedium: TextStyle(
              color: Colors.white), // Adjust other text styles as necessary
          titleLarge: TextStyle(
              color: Colors.white), // Used for large titles in the app
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey, // Customize button color if needed
        ),
      ),
      home: HomeScreen(),
    );
  }
}
