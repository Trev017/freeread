import 'package:flutter/material.dart';

class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({super.key});

  @override
  State<AppearanceSettingsPage> createState() => _MyAppearanceSettingsPage();
}

class _MyAppearanceSettingsPage extends State<AppearanceSettingsPage> {

  //Temporary view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance Settings Page", textAlign: TextAlign.center,),
        leading: GestureDetector(
          child: BackButton(),
          onTap: () {
            Navigator.pop(context);
        }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.red.shade100,
                  minimumSize: Size.fromHeight(90),
                ),
                child: const Text ("Default System Settings"),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.grey.shade50,
                  minimumSize: Size.fromHeight(90),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Light", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.grey.shade900,
                  minimumSize: Size.fromHeight(90),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Dark", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}