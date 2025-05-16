import 'package:flashedu/Flashcards/folder_list_page.dart';
import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';

import 'package:flashedu/Trivia/trivia_page.dart';
import 'package:flashedu/Flashcards/flashcard_page.dart';
import 'package:flashedu/Settings/config_page.dart';

import 'package:circle_nav_bar/circle_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  Color selectedColor = Colors.blueGrey;

  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int v) {
    _selectedIndex = v;
    setState(() {});
  }


  late PageController pageController;

  // Icones
  final List<Icon> icons = [
      Icon(Icons.quiz, color: Colors.white),
      Icon(Icons.note, color: Colors.white),
      Icon(Icons.settings, color: Colors.white),
  ];

  // Rotulos
  final List<String> label = ["Trivia", "FlashCards", "Configurações"];

  // paginas
  final List<Widget> pages = [
      TriviaPage(),
      FolderListPage(),
      ConfigPage(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _selectedIndex);

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        extendBody: true,
        bottomNavigationBar: CircleNavBar(
          activeIcons: icons,
          inactiveIcons: icons,
          levels: label,
          activeLevelsStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            ),
          inactiveLevelsStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
            ),
          // circleWidth: 60,
          circleColor: UserPreferencesService.getThemeColor(),
          color: UserPreferencesService.getThemeColor(),
          tabCurve: Curves.decelerate,
          iconCurve: Easing.linear,
          tabDurationMillSec: 500,
          iconDurationMillSec: 100,
          activeIndex: _selectedIndex,
          onTap:  (index) {
            setState(() {
              _selectedIndex = index;
              pageController.jumpToPage(_selectedIndex);
            });
          },
        ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (v) {
              setState(() {
                _selectedIndex = v;
              });
            },
            children: pages,

          ),
      );
  }
}
