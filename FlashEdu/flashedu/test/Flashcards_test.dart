import 'package:flashedu/Flashcards/folder_list_page.dart';
import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await UserPreferencesService.loadPreferences();
  });

  testWidgets('Verifica mensagem e botão de criar pasta', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FolderListPage()));

    // Verifica se mostra a mensagem de "sem pastas"
    expect(find.text('No folders yet. Tap + to create one.'), findsOneWidget);

    // Verifica se o botão flutuante existe
    expect(find.byIcon(Icons.create_new_folder), findsOneWidget);
  });

  testWidgets('Navega para a tela de criar pasta', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FolderListPage()));

    await tester.tap(find.byIcon(Icons.create_new_folder));
    await tester.pumpAndSettle();

    // Verifica se abriu a tela de nova pasta
    expect(find.text('New Folder'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
