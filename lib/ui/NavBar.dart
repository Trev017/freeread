//import 'package:adaptive_navbar/main.dart';
import 'package:flutter/material.dart';
import '../ui/Audioplayer.dart';
import 'home/HomePage.dart';
import 'catalog/CatalogPage.dart';
import 'search/SearchPage.dart';
import 'settings/SettingsPage.dart';
import 'package:miniplayer/miniplayer.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  //Setter for the minimum height of the miniplayer
  double minPlayerMinHeight = 60;

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          //Navigates to the home page
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home'
          ),
          //Navigates to the catalog page
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Catalog',
          ),
          //Navigates to the search page
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          //Navigates to the settings page
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int i) {
          setState(() {
            currentPageIndex = i;
          });
        },
      ),
      //Sets navigation to the intended pages
      body: Stack(
        children: [
          Offstage(
            offstage: currentPageIndex != 0,
            child: const HomePage(),
          ),
          Offstage(
            offstage: currentPageIndex != 1,
            child: const CatalogPage(),
          ),
          Offstage(
            offstage: currentPageIndex != 2,
            child: const SearchPage(),
          ),
          Offstage(
            offstage: currentPageIndex != 3,
            child: const SettingsPage(),
          ),
          Miniplayer(
            //backgroundColor: Colors.yellow.shade600,
            minHeight: minPlayerMinHeight,
            maxHeight: MediaQuery.of(context).size.height,
            builder: (height, percentage) {
              if (height <= minPlayerMinHeight) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  //color: Colors.yellow.shade100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //
                          const Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Test 1",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        //style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Test 2",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        //style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const Audioplayer();
            },
          )
        ],
      ),
      //backgroundColor: Colors.deepOrange.shade400,
    );
  }
}