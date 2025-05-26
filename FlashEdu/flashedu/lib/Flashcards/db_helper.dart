import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flashedu/models/folder.dart';
import 'package:flashedu/models/flashcard.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'flashcards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE flashcards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        front_text TEXT NOT NULL,
        back_text TEXT NOT NULL,
        folder_id INTEGER,
        FOREIGN KEY (folder_id) REFERENCES folders(id)
      )
    ''');
  }

  Future<int> insertFolder(Folder folder) async {
    final dbClient = await db;
    return await dbClient.insert('folders', folder.toMap());
  }

  Future<List<Folder>> getFolders() async {
    final dbClient = await db;
    final res = await dbClient.query('folders');
    return res.map((e) => Folder.fromMap(e)).toList();
  }

  Future<int> insertFlashcard(Flashcard flashcard) async {
    final dbClient = await db;
    return await dbClient.insert('flashcards', flashcard.toMap());
  }

  Future<List<Flashcard>> getFlashcardsByFolder(int folderId) async {
    final dbClient = await db;
    final res = await dbClient.query('flashcards', where: 'folder_id = ?', whereArgs: [folderId]);
    return res.map((e) => Flashcard.fromMap(e)).toList();
  }

  getAllFolders() {
    return getFolders();
  }


  // Delete folder
  Future<int> deleteFolder(int folderId) async {
    final dbClient = await db;
    // Delete flashcards in the folder
    await dbClient.delete('flashcards', where: 'folder_id = ?', whereArgs: [folderId]);
    // Delete folder
    return await dbClient.delete('folders', where: 'id = ?', whereArgs: [folderId]);
  }


  // Update name of the folder
  Future<int> updateFolder(Folder folder) async {
    final dbClient = await db;
    return await dbClient.update(
      'folders',
      folder.toMap(),
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }
}
