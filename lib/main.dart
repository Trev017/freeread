import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../ui/NavBar.dart';
import 'ui/AudioProvider.dart';
import 'package:hive/hive.dart';
//Class to start the program.
void main() async {
  //Provider.debugCheckInvalidValueType = null;
  //Initializes Hive to utilize a box.
  await Hive.initFlutter();
  await Hive.openBox('hive_local_db');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  void changeTheme(ThemeMode tm) {
    setState(() {
      themeMode = tm;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return ChangeNotifierProvider(
      create: (_) {
        AudioProvider();
        },
      child: MaterialApp(
          title: 'Free Read',
          //Defines the theme of the application.
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade400),
            textTheme: const TextTheme().apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(color: Colors.black),
              ),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            textTheme: const TextTheme().apply(
              bodyColor: Colors.lightBlueAccent.shade400,
              displayColor: Colors.lightBlueAccent.shade400,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent.shade400,
                textStyle: TextStyle(color: Colors.lightBlueAccent.shade400),
              ),
            ),
          ),
          themeMode: themeMode,
          //Creates the base application, begins with the home page
          home: const NavBar(),
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false
      ),
    );
  }
}