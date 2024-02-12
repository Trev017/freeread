import 'package:flutter/material.dart';
import '../../main.dart';

class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({super.key});

  @override
  State<AppearanceSettingsPage> createState() => _MyAppearanceSettingsPage();
}

class _MyAppearanceSettingsPage extends State<AppearanceSettingsPage> {

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
            //Sets the application's appearance to the current theme of the device
            Center(
              child: ElevatedButton(
                onPressed: () {
                  MyApp.of(context).changeTheme(ThemeMode.system);
                },
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.red.shade100,
                  minimumSize: Size.fromHeight(90),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Default System Settings", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            //Sets the application's appearance to light mode
            Center(
              child: ElevatedButton(
                onPressed: () {
                  MyApp.of(context).changeTheme(ThemeMode.light);
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
            //Sets the application's appearance to dark mode
            Center(
              child: ElevatedButton(
                onPressed: () {
                  MyApp.of(context).changeTheme(ThemeMode.dark);
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