import 'package:flutter/material.dart';
import 'AppearanceSettingsPage.dart';
import 'LanguageSettingsPage.dart';
//Class to display the settings page.
class SettingsPage extends StatefulWidget {

  //Class constructor
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _MySettingsPage();
}

class _MySettingsPage extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    //Navigator and MaterialPageRoute ensures that the NavBar persists
    return Navigator(
      onGenerateRoute: (RouteSettings rs) {
        return MaterialPageRoute(
          settings: rs,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Settings Page", textAlign: TextAlign.center,),
                leading: const Icon(Icons.settings),
              ),
              body: Container(
                padding: const EdgeInsets.all(80),
                child: Column(
                  children: [
                    //Redirects the user to the language settings page.
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSettingsPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const ContinuousRectangleBorder(),
                          backgroundColor: Colors.red.shade100,
                          minimumSize: const Size.fromHeight(90),
                        ),
                        child: const Text(
                          "Language Settings",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),
                    //Redirects the user to the appearance settings page.
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AppearanceSettingsPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const ContinuousRectangleBorder(),
                          backgroundColor: Colors.red.shade100,
                          minimumSize: const Size.fromHeight(90),
                        ),
                        child: const Text(
                          "Change Appearance",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),
                    //Alert dialog to display how to contact the developer.
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Contact Developer"),
                                content: const Text("You may contact the developer at TCapiendo@my.gcu.edu"),
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
                          shape: const ContinuousRectangleBorder(),
                          backgroundColor: Colors.red.shade100,
                          minimumSize: const Size.fromHeight(90),
                        ),
                        child: const Text(
                          "Contact Developer",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}