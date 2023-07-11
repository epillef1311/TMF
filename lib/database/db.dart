import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'fichas.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_fichas);
  }

  String get _fichas => '''
  CREATE TABLE fichas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomePersonagem TEXT
  )
  ''';

  Future<void> criarTabelaCaracteristicas(String nome) async {
    final database = await instance.database;

    await database.execute('''
      CREATE TABLE $nome (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        caracteristica TEXT
      )
    ''');
  }

  Future<void> inserirNome(String nome) async {
    final database = await instance.database;

    await database.transaction((txn) async {
      await txn.insert(
        'fichas',
        {'nomePersonagem': nome},
      );
    });

    await criarTabelaCaracteristicas(nome);
  }

  Future<void> inserirCaracteristica(String nome, String caracteristica) async {
    final database = await instance.database;

    await database.insert(
      nome,
      {'caracteristica': caracteristica},
    );
  }
}
