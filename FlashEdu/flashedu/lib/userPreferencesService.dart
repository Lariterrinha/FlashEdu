import 'package:flutter/material.dart';

class UserPreferencesService {

  // from database
  static Color _themeColor = Colors.blueGrey;
  static String? _difficulty;
  static int ?_selectedCategory;
  static int _selectedAmount = 10;

  // Theme __________________________________
  static getThemeColor(){
    return _themeColor;
  }

  static Future<void> setThemeColor(Color color) async {
    _themeColor = color;
  }


  // Difficulty __________________________________
  static getDifficulty(){
    return _difficulty;
  }

  static setDifficulty(String difficulty){
    if (difficulty == 'easy' || difficulty == 'medium' || difficulty == 'hard'){
      _difficulty = difficulty;
    }else{
      _difficulty = null;
    }
  }

  static setAmount(int amount) {
    _selectedAmount = amount;
  }

  static getAmount() {
    return _selectedAmount;
  }

  // Category __________________________________
  static setCategory(int category) {
    if (category >= 9 && category <= 32){
      _selectedCategory = category;
    }else{
      _selectedCategory = null;
    };
  }

  static getCategory() {
    return _selectedCategory;
  }

}
