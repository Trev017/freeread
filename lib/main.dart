import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniplayer/miniplayer.dart';
import 'dart:convert';
import '../model/BookModel.dart';
import '../ui/HomePage.dart';
import '../ui/NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Free Read',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade400),
          useMaterial3: true,
        ),
        home: NavBar(),
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false
    );
  }
}