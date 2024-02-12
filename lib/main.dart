import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniplayer/miniplayer.dart';
import 'dart:convert';
import '../model/BookModel.dart';
import 'ui/home/HomePage.dart';
import '../ui/NavBar.dart';

void main() {
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
    return MaterialApp(
        title: 'Free Read',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade400),
          textTheme: TextTheme().apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: TextStyle(color: Colors.black),
            ),
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
          useMaterial3: true,
          textTheme: TextTheme().apply(
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
        home: NavBar(),
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false
    );
  }
}