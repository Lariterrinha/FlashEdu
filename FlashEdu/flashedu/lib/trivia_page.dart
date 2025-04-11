import 'package:flutter/material.dart';

class TriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trivia')),
      body: Center(child: Text('Aqui ficarão as perguntas de Trivia.')),
    );
  }
}