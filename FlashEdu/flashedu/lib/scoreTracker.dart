import 'dart:math';

class ScoreTracker {
  int _score = 0;
  int _correctAnswers = 0;
  int _currentAttempts = 0;

  int get score => _score;
  int get correctAnswers => _correctAnswers;
  int get currentAttempts => _currentAttempts;

  void incrementAttempt() => _currentAttempts++;

  int getPotentialScore({required String difficulty, required int attempts}) {
    final basePoints = switch (difficulty.toLowerCase()) {
      'easy' => 10,
      'medium' => 20,
      'hard' => 30,
      _ => 0,
    };
    return basePoints ~/ pow(2, attempts).toInt();
  }

  void registerCorrectAnswer({required String difficulty, required int attempts}) {
    _score += getPotentialScore(difficulty: difficulty,  attempts: attempts);
    _correctAnswers = (attempts < 1 ? _correctAnswers + 1 : _correctAnswers);     // Correct Answers only if first attempt
    _currentAttempts = 0; // Reseta para próxima pergunta
  }

  void resetAttempts() {
    _currentAttempts = 0;
  }

  void resetGame(){
    _score = 0;
    _correctAnswers = 0;
    _currentAttempts = 0;
  }
}