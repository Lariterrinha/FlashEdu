import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import '../models/folder.dart';
import '../models/flashcard.dart';
import 'db_helper.dart';

class FlashcardPage extends StatelessWidget {
  final Folder folder;
  FlashcardPage({required this.folder});

  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController controller = SwipeableCardSectionController();
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text('Folder: ${folder.name}', style: TextStyle(color: Colors.white)),
          backgroundColor: UserPreferencesService.getThemeColor(),
          iconTheme: IconThemeData(color: Colors.white),
      ),

      body: FutureBuilder<List<Flashcard>>(
        future: DatabaseHelper().getFlashcardsByFolder(folder.id!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data!.isEmpty) return Center(child: Text('No flashcard to show.'));

          return SwipeableCardsSection(
            cardController: controller,
            context: context,
            items: snapshot.data!.map((fc) => FlashCard(
              width: screen.width * 0.9,
              height: screen.height * 0.5,
              frontWidget: () => Container(
                decoration: BoxDecoration(
                  color: UserPreferencesService.getThemeColor(),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(fc.frontText, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              backWidget: () => Container(
                decoration: BoxDecoration(
                  color: Color.lerp(UserPreferencesService.getThemeColor(), Colors.white, 0.3) ,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(fc.backText, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),


            )).toList(),
            enableSwipeUp: false,
            enableSwipeDown: false,
            onCardSwiped: (dir, index, widget) {},
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: UserPreferencesService.getThemeColor(),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        tooltip: 'Add a flashcard',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateFlashcardPage(folder: folder),
            ),
          );
          // rebuild to update the flashcards
          (context as Element).markNeedsBuild();
        },
      ),

    );
  }
}

class CreateFlashcardPage extends StatelessWidget {
  final Folder folder;
  final TextEditingController frontController = TextEditingController();
  final TextEditingController backController = TextEditingController();

  CreateFlashcardPage({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Flashcard: "${folder.name}"')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: frontController, decoration: InputDecoration(labelText: 'Front')),
          TextField(controller: backController, decoration: InputDecoration(labelText: 'Back')),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              await DatabaseHelper().insertFlashcard(
                  Flashcard(
                    frontText: frontController.text,
                    backText: backController.text,
                    folderId: folder.id!,
                  )
              );
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
