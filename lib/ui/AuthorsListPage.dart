import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';

class AuthorsListPage extends StatefulWidget {
  const AuthorsListPage({super.key});

  @override
  State<AuthorsListPage> createState() => _MyAuthorsListPage();
}

class _MyAuthorsListPage extends State<AuthorsListPage> {

  //Temporary view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Authors", textAlign: TextAlign.center,),
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