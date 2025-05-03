import 'package:flashedu/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Abouttheapp extends StatefulWidget {
  @override
  _AbouttheappState createState() => _AbouttheappState();
}

class _AbouttheappState extends State<Abouttheapp> {
  final PageController _controller = PageController();

  void _onContinue() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                // Page 1: Trivia
                _buildPage(
                  "Challenge Your Knowledge!",
                  "Answer quick trivia questions, earn points, and break records!",
                  Icons.quiz,
                  //AnimatedIcons.menu_close,
                ),

                // Page 2: Flashcards
                _buildPage(
                  "Smart Flashcards",
                  "Boost your memory with spaced repetition. Perfect for fast learning!",
                  Icons.lightbulb_outline,
                ),

                // Page 3: Progress
                _buildPage(
                  "Track Your Growth",
                  "See your score and always improve yourself",
                  Icons.trending_up,
                ),
                _buildCreditosPage(showButton: true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: WormEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.deepOrange,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditosPage({bool showButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Developed by:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Larissa Anielle Terrinha',
            style: TextStyle(fontSize: 18),
          ),

          if (showButton) ...[
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade800,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: Text('Continue'),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.deepPurple.shade800),
          SizedBox(height: 24),
          Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(subtitle, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}