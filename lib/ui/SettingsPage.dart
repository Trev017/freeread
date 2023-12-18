import 'package:flutter/material.dart';
import '../ui/AppearanceSettingsPage.dart';
import '../ui/LanguageSettingsPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _MySettingsPage();
}

class _MySettingsPage extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page", textAlign: TextAlign.center,),
        leading: const Icon(Icons.settings),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: Column(
          children: [
            //Navigates to the language settings page
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSettingsPage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.red.shade100,
                  minimumSize: Size.fromHeight(90),
                ),
                child: const Text ("Language Settings"),
              ),
            ),
            const Spacer(),
            //Navigates to the appearance settings page
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppearanceSettingsPage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.red.shade100,
                  minimumSize: Size.fromHeight(90),
                ),
                child: const Text ("Change Appearance"),
              ),
            ),
            const Spacer(),
            //Opens an alert box on how to contact the developer
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Contact Developer"),
                          content: const Text("You may contact the developer at <>"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Continue');
                              },
                              child: const Text("Continue"),
                            ),
                          ],
                        );
                      },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.red.shade100,
                  minimumSize: Size.fromHeight(90),
                ),
                child: const Text ("Contact Developer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}