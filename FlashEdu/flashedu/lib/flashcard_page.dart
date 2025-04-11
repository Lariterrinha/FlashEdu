import 'package:flutter/material.dart';

class FlashcardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcards')),
      body: Center(child: Text('Aqui o usuário poderá criar e revisar flashcards.')),
    );
  }
}
