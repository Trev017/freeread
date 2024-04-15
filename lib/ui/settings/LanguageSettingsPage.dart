import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _MyLanguageSettingsPage();
}

class _MyLanguageSettingsPage extends State<LanguageSettingsPage> {

  //Temporary view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Settings Page", textAlign: TextAlign.center,),
        leading: GestureDetector(
            child: const BackButton(),
            onTap: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: const Column(
          children: [
            Center(child: Text ("Work in Progress"),),
          ],
        ),
      ),
    );
  }
}