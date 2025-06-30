import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import '../models/folder.dart';
import '../models/flashcard.dart';
import 'db_helper.dart';

class FlashcardPage extends StatefulWidget {
  final Folder folder;
  const FlashcardPage({super.key, required this.folder});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  final SwipeableCardSectionController _controller = SwipeableCardSectionController();
  List<FlashCard> _itens = [];
  int _indexFlashcards = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Carrega os dados quando a tela é iniciada
    _reloadData();
  }

  // Função dedicada para carregar e recarregar os dados
  Future<void> _reloadData() async {
    setState(() {
      _isLoading = true;
    });

    // Busca os dados atualizados do banco
    final data = await DatabaseHelper().getFlashcardsByFolder(widget.folder.id!);
    final screen = MediaQuery.of(context).size;

    // Atualiza a lista de widgets
    _itens = data.map((fc) {
      return FlashCard(
        width: screen.width * 0.9,
        height: screen.height * 0.5,
        frontWidget: () => Container(
          decoration: BoxDecoration(
            color: UserPreferencesService.getThemeColor(),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(fc.frontText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        backWidget: () => Container(
          decoration: BoxDecoration(
            color:
            Color.lerp(UserPreferencesService.getThemeColor(), Colors.white, 0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(fc.backText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      );
    }).toList();

    // Reseta o índice e finaliza o carregamento
    setState(() {
      _indexFlashcards = _itens.length >= 3 ? 3 : _itens.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasta: ${widget.folder.name}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: UserPreferencesService.getThemeColor(),
        iconTheme: const IconThemeData(color: Colors.white),
        // Adiciona uma lista de widgets (botões) na AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh), // Ícone do botão
            tooltip: 'Recarregar', // Mensagem que aparece ao pressionar e segurar
            // Chama a mesma função que recarrega os dados
            onPressed: _reloadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _itens.isEmpty
          ? const Center(child: Text('Nenhum flashcard para mostrar.'))
          : SwipeableCardsSection(
        cardController: _controller,
        context: context,
        items: _itens.length >= 3 ? _itens.sublist(0, 3) : _itens,
        enableSwipeUp: true,
        enableSwipeDown: true,
        onCardSwiped: (dir, index, widget) {
          if (_indexFlashcards < _itens.length) {
            _controller.addItem(_itens[_indexFlashcards]);
            _indexFlashcards++;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: UserPreferencesService.getThemeColor(),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        tooltip: 'Adicionar flashcard',
        onPressed: () async {
          // Navega para a tela de criação e AGUARDA um resultado
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateFlashcardPage(folder: widget.folder),
            ),
          );

          // Se o resultado for 'true', recarrega os dados
          if (result == true) {
            _reloadData();
          }
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
              Navigator.pop(context, true);
            },
          )
        ]),
      ),
    );
  }
}
