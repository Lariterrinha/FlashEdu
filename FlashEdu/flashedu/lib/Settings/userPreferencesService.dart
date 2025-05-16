import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserPreferencesService {
  // Valores padrão
  static Color _themeColor = Colors.blueGrey;
  static String? _difficulty;
  static int? _selectedCategory;
  static int _selectedAmount = 10;

  // Inicialização do banco de dados
  static Future<sql.Database> _getDatabase() async {
    return sql.openDatabase(
      'userPreferences.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await database.execute("""CREATE TABLE IF NOT EXISTS userPreferences(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          theme TEXT,
          difficulty TEXT,
          category INTEGER,
          amount INTEGER NOT NULL,
          isFirstOpen BOOLEAN NOT NULL DEFAULT 1, 
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )""");

        //print("Database created");

        // Inserir dados iniciais
        await database.insert('userPreferences', {
          'theme': _colorToString(_themeColor),
          'difficulty': _difficulty,
          'category': _selectedCategory,
          'amount': _selectedAmount,
          'isFirstOpen': 1,  // Valor explícito
        });
      },
    );
  }

  // Métod privated to update the database
  static Future<void> _updateDatabase({
    Color? theme,
    String? difficulty,
    int? category,
    int? amount,
    bool? isFirstOpen,

  }) async {
    final db = await _getDatabase();
    final count = await db.rawQuery('SELECT COUNT(*) FROM userPreferences');

    final data = {
      'theme': _colorToString(theme ?? _themeColor),
      'difficulty': difficulty ?? _difficulty,
      'category': category ?? _selectedCategory,
      'amount': amount ?? _selectedAmount,
      'isFirstOpen': (isFirstOpen ?? UserPreferencesService.isFirstOpen) ? 1 : 0,
    };

    if (count.first.values.first == 0) {
      await db.insert('userPreferences', data);
    } else {
      await db.update(
        'userPreferences',
        data,
        where: 'id = ?',
        whereArgs: [1],
      );
    }
  }

  static Future<void> loadPreferences() async {
    try {
      final db = await _getDatabase();
      final List<Map<String, dynamic>> preferences =
      await db.query('userPreferences', limit: 1);

      if (preferences.isNotEmpty) {
        _themeColor = _stringToColor(preferences[0]['theme'] as String);
        _difficulty = preferences[0]['difficulty'] as String?;
        _selectedCategory = preferences[0]['category'] as int?;
        _selectedAmount = preferences[0]['amount'] as int;
        isFirstOpen = (preferences[0]['isFirstOpen'] as int) == 1;
      }
    } catch (e) {
      print("Erro ao carregar preferências: $e");
      _resetToDefaults();
    }
  }

  static void _resetToDefaults() {
    _themeColor = Colors.blueGrey;
    _difficulty = null;
    _selectedCategory = null;
    _selectedAmount = 10;
    isFirstOpen = true;
  }


  // Conversão de cores
  static String _colorToString(Color color) => color.value.toString();
  static Color _stringToColor(String colorString) => Color(int.parse(colorString));

  // Theme _____________________________________________________________
  static Color getThemeColor() => _themeColor;

  static Future<void> setThemeColor(Color color) async {
    _themeColor = color;
    await _updateDatabase(theme: color);
  }

  // Difficulty ________________________________________________________
  static String? getDifficulty() => _difficulty;

  static Future<void> setDifficulty(String difficulty) async {
    if (difficulty == 'easy' || difficulty == 'medium' || difficulty == 'hard') {
      _difficulty = difficulty;
    } else {
      _difficulty = null;
    }
    await _updateDatabase(difficulty: _difficulty);
  }

  // Amount ____________________________________________________________
  static int getAmount() => _selectedAmount;

  static Future<void> setAmount(int amount) async {
    _selectedAmount = amount;
    await _updateDatabase(amount: amount);
  }

  // Category __________________________________________________________
  static int? getCategory() => _selectedCategory;

  static Future<void> setCategory(int category) async {
    if (category >= 9 && category <= 32) {
      _selectedCategory = category;
    } else {
      _selectedCategory = null;
    }
    await _updateDatabase(category: _selectedCategory);
  }



  static bool isFirstOpen = true;

// Verifica se é a primeira vez
  static Future<bool> checkFirstOpen() async {
    final db = await _getDatabase();
    final result = await db.query(
        'userPreferences',
        columns: ['isFirstOpen'],
        limit: 1
    );

    if (result.isEmpty) {
      return true; // Se não há registros, é a primeira vez
    }
    return result.first['isFirstOpen'] == 1;
  }


  static get getIsFirstOpen => isFirstOpen;

  // Marca que o app já foi aberto
  static Future<void> markAppOpened() async {
    final db = await _getDatabase();
    await db.update(
        'userPreferences',
        {'isFirstOpen': 0},  // 0 = false
        where: 'id = 1'
    );
    isFirstOpen = false;
  }
}