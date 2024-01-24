import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveThemeToPreferences();
    notifyListeners();
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  ThemeData get lightTheme {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 190, 173, 253),
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        searchBarTheme: SearchBarThemeData(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shadowColor: MaterialStateProperty.all(Colors.black),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 190, 173, 253),
          shadowColor: Colors.black87,
          surfaceTintColor: Colors.amber,
          indicatorColor: Color.fromARGB(255, 190, 173, 253),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 190, 173, 253),
          selectedItemColor: const Color.fromARGB(255, 190, 173, 253),
          selectedIconTheme:
              IconThemeData(color: Colors.black.withOpacity(0.8)),
          unselectedIconTheme:
              IconThemeData(color: Colors.black.withOpacity(0.8)),
          unselectedItemColor: Colors.black.withOpacity(0.60),
          selectedLabelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: const Color.fromARGB(255, 10, 54, 134),
          textColor: Colors.black,
          tileColor: const Color.fromARGB(255, 225, 214, 255),
          selectedTileColor: Colors.green,
          selectedColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 238, 238, 238).withOpacity(0.9),
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 21,
          ),
        ),
        primaryColor: Colors.black.withOpacity(0.7),
        shadowColor: Colors.black,
        hintColor: const Color.fromARGB(251, 110, 110, 110),
        secondaryHeaderColor: Colors.black,
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 190, 173, 253),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 190, 173, 253),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ));
  }
}
