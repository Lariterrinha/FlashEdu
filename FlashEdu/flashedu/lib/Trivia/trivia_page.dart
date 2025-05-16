import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'scoreTracker.dart';


// Main trivia game screen
class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  TriviaPageState createState() => TriviaPageState();
}

class TriviaPageState extends State<TriviaPage> {

  // Variables for managing game state
  final UserPreferencesService _userPreferencesService = UserPreferencesService();     // User preferences service
  final _scoreTracker = ScoreTracker();               // Tracks player's score and progress
  List<Map<String, dynamic>> _questions = [];         // Stores questions from API
  int _currentQuestionIndex = 0;                      // Current question index
  String? _selectedDifficulty;                         // Selected difficulty level
  int _selectedAmount = 10;                           // Number of questions to fetch
  int ?_selectedCategory;                             // Selected category (optional)
  bool _isLoading = false;                            // Loading state
  String? _selectedAnswer;                            // User's selected answer
  String? _correctAnswer;                             // Correct answer for current question
  List<String> _shuffledAnswers = [];                 // Shuffled answer options

  // Map of categories
  final Map<int, String> categories = {
    9: 'General Knowledge',
    10: 'Entertainment: Books',
    11: 'Entertainment: Film',
    12: 'Entertainment: Music',
    13: 'Entertainment: Musicals & Theatres',
    14: 'Entertainment: Television',
    15: 'Entertainment: Video Games',
    16: 'Entertainment: Board Games',
    17: 'Science & Nature',
    18: 'Science: Computers',
    19: 'Science: Mathematics',
    20: 'Mythology',
    21: 'Sports',
    22: 'Geography',
    23: 'History',
    24: 'Politics',
    25: 'Art',
    26: 'Celebrities',
    27: 'Animals',
    28: 'Vehicles',
    29: 'Entertainment: Comics',
    30: 'Science: Gadgets',
    31: 'Entertainment: Japanese Anime & Manga',
    32: 'Entertainment: Cartoon & Animations',
  };

  @override
  void initState() {
    super.initState();
    _selectedDifficulty = UserPreferencesService.getDifficulty();
    _selectedAmount = UserPreferencesService.getAmount();
    _selectedCategory = UserPreferencesService.getCategory();
    _fetchQuestions();      // Load questions when screen starts
  }

  // Fetches questions from Open Trivia API
  Future<void> _fetchQuestions()  async {

    // Inicilize variables
    setState(() {
      _isLoading = true;
      _questions = [];
      _selectedAnswer = null;
      _correctAnswer = null;
      _shuffledAnswers = [];
      _currentQuestionIndex = 0;
    });

    // try getting questions from API
    try {

      final response = await http.get(Uri.parse(
          'https://opentdb.com/api.php?'
              'amount=$_selectedAmount'
              '${_selectedCategory != null ? '&category=$_selectedCategory' : ''}'
              '${_selectedDifficulty != null ? '&difficulty=$_selectedDifficulty' : ''}'
              '&type=multiple'
      ));

      // if successful, update state
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _questions.clear();
          _questions.addAll(List<Map<String, dynamic>>.from(data['results']));
          _scoreTracker.resetAttempts();
          if (_questions.isNotEmpty) {
            _prepareQuestion();
          }
        });
      }
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      setState((){

        // If it didnt fetch correctly it will try again
        if (_questions.isEmpty){
          _fetchQuestions();
        }
        else{
          _isLoading = false;
        }
      });
    }
  }

  // Prepares current question and answers
  void _prepareQuestion() {
    final currentQuestion = _questions[_currentQuestionIndex];
    // Get and decode correct answer
    _correctAnswer = _decodeHtml(currentQuestion['correct_answer']);

    // Mix correct and incorrect answers
    _shuffledAnswers = [];
    _shuffledAnswers.add(_correctAnswer!);
    for (var answer in currentQuestion['incorrect_answers']) {
      _shuffledAnswers.add(_decodeHtml(answer));
    }
    _shuffledAnswers.shuffle();

    // Reset selection and attempts
    _selectedAnswer = null;
    _scoreTracker.resetAttempts();
  }

  // Fixes HTML encoded characters in questions/answers
  String _decodeHtml(String html)  {

    // Handle numeric entities (decimal and hexadecimal)
    var output = html.replaceAllMapped(
      RegExp(r'&(#(\d+)|#x([0-9a-fA-F]+));'),
          (match) {
        final number = match.group(2) != null
            ? int.parse(match.group(2)!) // Decimal
            : int.parse(match.group(3)!, radix: 16); // Hex
        return String.fromCharCode(number);
      },
    );

    // Handle named entities (including all accented chars)
    final entityMap = {
      // Common
      '&quot;': '"', '&amp;': '&', '&apos;': "'", '&lt;': '<', '&gt;': '>',
      '&nbsp;': ' ', '&copy;': '©', '&reg;': '®', '&euro;': '€',
      '&pound;': '£', '&yen;': '¥', '&cent;': '¢', '&sect;': '§',

      // Accented letters (Latin)
      '&Aacute;': 'Á', '&aacute;': 'á', '&Agrave;': 'À', '&agrave;': 'à',
      '&Acirc;': 'Â', '&acirc;': 'â', '&Auml;': 'Ä', '&auml;': 'ä',
      '&Atilde;': 'Ã', '&atilde;': 'ã', '&AElig;': 'Æ', '&aelig;': 'æ',
      '&Ccedil;': 'Ç', '&ccedil;': 'ç', '&Eacute;': 'É', '&eacute;': 'é',
      '&Egrave;': 'È', '&egrave;': 'è', '&Ecirc;': 'Ê', '&ecirc;': 'ê',
      '&Euml;': 'Ë', '&euml;': 'ë', '&Iacute;': 'Í', '&iacute;': 'í',
      '&Igrave;': 'Ì', '&igrave;': 'ì', '&Icirc;': 'Î', '&icirc;': 'î',
      '&Iuml;': 'Ï', '&iuml;': 'ï', '&Ntilde;': 'Ñ', '&ntilde;': 'ñ',
      '&Oacute;': 'Ó', '&oacute;': 'ó', '&Ograve;': 'Ò', '&ograve;': 'ò',
      '&Ocirc;': 'Ô', '&ocirc;': 'ô', '&Ouml;': 'Ö', '&ouml;': 'ö',
      '&Otilde;': 'Õ', '&otilde;': 'õ', '&OElig;': 'Œ', '&oelig;': 'œ',
      '&Scaron;': 'Š', '&scaron;': 'š', '&Uacute;': 'Ú', '&uacute;': 'ú',
      '&Ugrave;': 'Ù', '&ugrave;': 'ù', '&Ucirc;': 'Û', '&ucirc;': 'û',
      '&Uuml;': 'Ü', '&uuml;': 'ü', '&Yacute;': 'Ý', '&yacute;': 'ý',
      '&Yuml;': 'Ÿ', '&yuml;': 'ÿ', '&szlig;': 'ß',

      // Math/Symbols
      '&deg;': '°', '&plusmn;': '±', '&times;': '×', '&divide;': '÷',
      '&frac12;': '½', '&frac14;': '¼', '&frac34;': '¾', '&micro;': 'µ',
      '&para;': '¶', '&middot;': '·', '&bull;': '•', '&hellip;': '…',
      '&prime;': '′', '&Prime;': '″', '&oline;': '‾', '&frasl;': '⁄',
      '&ndash;': '–', '&mdash;': '—', '&lsquo;': '‘', '&rsquo;': '’',
      '&sbquo;': '‚', '&ldquo;': '“', '&rdquo;': '”', '&bdquo;': '„',
      '&dagger;': '†', '&Dagger;': '‡', '&permil;': '‰', '&lsaquo;': '‹',
      '&rsaquo;': '›', '&trade;': '™',
    };

    // Replace all known entities
    entityMap.forEach((entity, char) {
      output = output.replaceAll(entity, char);
    });

    return output;
  }

  /* Handles user answer selection
  *       - handles wrong/correct answer (using scoreTracker)
  *       - change buttons color to indicate correct/wrong
  */
  void _handleAnswer(String selectedAnswer){
    setState(() {
      _selectedAnswer = selectedAnswer;

      if (selectedAnswer == _correctAnswer) {
        // Correct answer
        _scoreTracker.registerCorrectAnswer(
          difficulty: _questions[_currentQuestionIndex]['difficulty'],
          attempts: _scoreTracker.currentAttempts,
        );

        // Wait 1 sec the go to next question
        Future.delayed(const Duration(seconds: 1), () {
          _moveToNextQuestion();
        });

      } else {
        // Wrong awnser
        _scoreTracker.incrementAttempt();
      }
    });
  }

  void _moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _prepareQuestion();
      });
    } else {
      _showResults();
    }
  }


  // Builds an answer button with visual feedback
  Widget _buildAnswerButton(String answer) {
    bool isCorrect = answer == _correctAnswer;
    bool isSelected = answer == _selectedAnswer;
    bool showCorrect = _selectedAnswer == _correctAnswer || _scoreTracker.currentAttempts >= 3;

    Color backgroundColor = Colors.blue.shade100; // Cor padrão

    if (isSelected) {
      backgroundColor = isCorrect
          ? Colors.green.shade400 // Acertou
          : Colors.red.shade400;  // Errou
    } else if (showCorrect && isCorrect) {
      backgroundColor = Colors.green.shade400; // Mostra a correta após tentativas
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50)),
        onPressed: _selectedAnswer == null ||
    (_selectedAnswer != _correctAnswer)
    ? () => _handleAnswer(answer)
        : null,
        child: Text(answer),
    ),
    );
  }

  // Shows final results dialog
  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Results 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📊 Total Score: ${_scoreTracker.score}',
                style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 8), // Space between the lines

            Text('✅ First Attempt Answers: ${_scoreTracker.correctAnswers}/${_questions.length}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _scoreTracker.resetGame();
              _fetchQuestions();
            },
            child: const Text('NEW QUIZ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia - ${ _isLoading ? '0': _scoreTracker.score} points', style: TextStyle(color: Colors.white)),
        backgroundColor: UserPreferencesService.getThemeColor(),
      ),

      body:

      // If is lodding question show the cicle progress indicator
      (_isLoading) ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading questions...'),
          ],
        ),
      )


      // Show the page if question are loaded
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ROW WITH ALL THE DROPDOWNS MENUS
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // Difficulty selection
                    Expanded(
                    child: DropdownButton<String>(
                      value: (_selectedDifficulty == null? 'random' : _selectedDifficulty),
                      items: ['random', 'easy', 'medium', 'hard']
                          .map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(d, style: TextStyle(fontSize: 10)),
                      )).toList(),

                      onChanged: (value){
                        setState(() => _selectedDifficulty = (value ==  'random'? null : value));
                        _scoreTracker.resetGame();
                        _fetchQuestions();
                      }
                      ),
                    ),


                    // Category selection
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedCategory,
                        items: [
                          // Option "Any Category" (null)
                          DropdownMenuItem<int>(
                            value: null,
                            child: Text('Any Category', style: TextStyle(fontSize: 10)),
                          ),

                          // Rest of the itens of the dropdown
                          ...categories.entries.map((entry) => DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value, style: TextStyle(fontSize: 10)),
                          )).toList(),
                        ],
                        onChanged: (selectedId) {
                          setState(() {
                            _selectedCategory = selectedId; // selectedId é int ou null
                            _scoreTracker.resetGame();
                            _fetchQuestions();
                          });
                        },
                        hint: Text('Select Category'),
                        isExpanded: true,
                      ),
                    ),


                    // Number of questions selection
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedAmount,
                        items: [5, 10, 15, 20]
                            .map((a) => DropdownMenuItem(
                          value: a,
                          child: Text('$a questions', style: TextStyle(fontSize: 10)),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedAmount = value!);
                          _scoreTracker.resetGame();
                          _fetchQuestions();
                        }
                      ),
                    ),
                  ]
              ),

              // Progress bar
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue.shade600),
              ),

              // Space between itens
              const SizedBox(height: 16),

              // Question counter
              Text(
                'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 16),

              // Question and answers
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        _decodeHtml(
                            _questions[_currentQuestionIndex]['question']),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ..._shuffledAnswers.map(_buildAnswerButton),
                    ],
                  ),
                ),
              ),

            ],
        ),
      ),
    );
  }
}