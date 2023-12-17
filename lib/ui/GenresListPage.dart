import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';

class GenresListPage extends StatefulWidget {
  const GenresListPage({super.key});

  @override
  State<GenresListPage> createState() => _MyGenresListPage();
}

class _MyGenresListPage extends State<GenresListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Genres", textAlign: TextAlign.center,),
        leading: GestureDetector(
            child: BackButton(),
            onTap: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: const Column(
          children: [
            Center(child: const Text ("Work in Progress"),),
          ],
        ),
      ),
    );
  }
}