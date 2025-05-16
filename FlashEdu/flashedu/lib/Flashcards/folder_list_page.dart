import 'package:flutter/material.dart';
import '../Settings/userPreferencesService.dart';
import '../models/flashcard.dart';
import '../models/folder.dart';
import 'db_helper.dart';
import 'flashcard_page.dart';

class FolderListPage extends StatefulWidget {
  @override
  _FolderListPageState createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {

  List<Folder> folders = [];

  @override
  void initState() {
    super.initState();
    loadFolders();
  }


  Future<void> loadFolders() async {
    final data = await DatabaseHelper().getAllFolders();
    setState(() {
      folders = data;
    });
  }


  Future<void> _goToCreateFolderPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreateFolderPage()),
    );
    loadFolders(); // Recarrega após voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('FlashCards', style: TextStyle(color: Colors.white)),
        backgroundColor: UserPreferencesService.getThemeColor(),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: folders.isEmpty
          ? Center(child: Text('No folders yet. Tap + to create one.'))
          : ListView.builder(
        itemCount: folders.length,
        itemBuilder: (_, index) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FlashcardPage(folder: folders[index])),
            );
          },
          leading: Icon(Icons.folder),
            title: Text(folders[index].name),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0), // Empurra o botão pra cima do nav
        child: FloatingActionButton(
          backgroundColor: UserPreferencesService.getThemeColor(),
          foregroundColor: Colors.white,
            onPressed: _goToCreateFolderPage,
          child: Icon(Icons.create_new_folder),
          tooltip: 'Create a new folder',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}


// SUPPORT !

class CreateFolderPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Folder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _controller, decoration: InputDecoration(labelText: 'Nome da pasta')),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              await DatabaseHelper().insertFolder(Folder(name: _controller.text));
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}