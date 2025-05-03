import 'package:flashedu/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';


class FlashcardPage extends StatelessWidget {

  String front_text = 'front_text';
  String back_text = 'back_text';
  int counter = 0;

  @override
  Widget build(BuildContext context) {

    Size tela = MediaQuery.of(context).size;
    SwipeableCardSectionController _cardController = SwipeableCardSectionController();

    return Scaffold(
      appBar: AppBar(title: Text('Flashcards', style: TextStyle(color: Colors.white)),
          backgroundColor: UserPreferencesService.getThemeColor()
      ),
      body: Center(
        child:
        SwipeableCardsSection(
            cardController: _cardController,
            context: context,
            items: [
              FlashCard(
                width: tela.width * 0.85,
                height: tela.height * 0.5,
                frontWidget: () => Container(
                    child: Text(front_text),
                    color: Colors.blue
                ),
                backWidget: () => Container(
                    child: Text(back_text),
                    color: Colors.amber
                )
              )
            ],
            enableSwipeUp: false,
            enableSwipeDown: false,
            onCardSwiped: (dir, index, widget) {

              if (dir == Direction.left) {
                print('direita');
              } else if (dir == Direction.right) {
                print('esquerda');
              }
            },
        )
      )
    );
  }
}
