import 'package:flutter/material.dart';

import 'package:flashedu/trivia_page.dart';
import 'package:flashedu/flashcard_page.dart';
import 'package:flashedu/config_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TriviaPage(),
    FlashcardPage(),
    ConfigPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Trivia'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Flashcards'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
