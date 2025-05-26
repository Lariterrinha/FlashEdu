import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flashedu/main.dart';
import 'package:flashedu/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await UserPreferencesService.loadPreferences();
    UserPreferencesService.isFirstOpen = true;
  });

  testWidgets('TC5.1 e TC5.2 - Testa Swipe entre pagias e o botão de continuar aparece na quarta e ultima página', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Navega até a última página (4 páginas no total → 3 swipes)
    for (int i = 0; i < 3; i++) {
      await tester.fling(find.byType(PageView), const Offset(-500.0, 0.0), 1000);
      await tester.pumpAndSettle();
    }

    // Verifica se o botão "Continue" está presente
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('TC5.3 - Botão de continuar navega para a HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Navega até a última página
    for (int i = 0; i < 3; i++) {
      await tester.fling(find.byType(PageView), const Offset(-500.0, 0.0), 1000);
      await tester.pumpAndSettle();
    }

    // Clica no botão "Continue"git push origin --force
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Verifica se navegou para a HomePage
    expect(find.byType(HomePage), findsOneWidget);
  });
}
