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

    if (!mounted) return; // impede setState se widget foi desmontado

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

  // Função para editar o nome da pasta
  Future<void> _editFolder(Folder folder) async {
    TextEditingController controller = TextEditingController(text: folder.name);

    bool? updated = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Folder Name'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Folder Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (updated == true) {
      final folderName = controller.text.trim();
      if (folderName.isNotEmpty) {
        folder.name = folderName;
        await DatabaseHelper().updateFolder(folder);
        loadFolders(); // Recarrega após edição
      }
    }
  }



  // Função para excluir a pasta
  Future<void> _deleteFolder(Folder folder) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Folder'),
          content: Text('Are you sure you want to delete this folder?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await DatabaseHelper().deleteFolder(folder.id!);
      loadFolders(); // Recarrega após deletar
    }
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
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                _editFolder(folders[index]);
              } else if (value == 'delete') {
                _deleteFolder(folders[index]);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
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
class CreateFolderPage extends StatefulWidget {
  @override
  _CreateFolderPageState createState() => _CreateFolderPageState();
}

class _CreateFolderPageState extends State<CreateFolderPage> {
  final TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Folder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _controller, decoration: InputDecoration(labelText: 'Folder Name')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: UserPreferencesService.getThemeColor(), foregroundColor: Colors.white),
            child: Text('Save'),
            onPressed: () async {
              final folderName = _controller.text.trim();
              if (folderName.isNotEmpty) {
                final dbHelper = DatabaseHelper();
                await dbHelper.insertFolder(Folder(name: folderName));

                if (context.mounted) {
                  Navigator.pop(context); // Só navega se o contexto ainda existir
                }
              }
            },
          )
        ]),
      ),
    );
  }
}