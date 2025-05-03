import 'package:flashedu/AboutTheApp.dart';
import 'package:flashedu/trivia_page.dart';
import 'package:flashedu/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await UserPreferencesService.loadPreferences();
  } catch (e) {
    print("Error loading db: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashEdu',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: UserPreferencesService.getIsFirstOpen ? Abouttheapp(): HomePage() ,

    );
  }

}