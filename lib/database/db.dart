import 'package:app/database/models/ficha.dart';
import 'package:sqflite/sqflite.dart';
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

  Future<void> criarTabelaTalentos(int id) async {
    final database = await instance.database;
    final tableName = 'table_$id';

    await database.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeTalento TEXT,
        descricao TEXT,
        preRequisito TEXT,
        especial TEXT,
        livro TEXT
        )
    ''');
  }

  Future<int> buscarIdPorNome(String nome) async {
    final database = await DB.instance.database;
    final result = await database.query(
      'fichas',
      where: 'nomePersonagem = ?',
      whereArgs: [nome],
    );
    if (result.isNotEmpty) {
      final id = result.first['id'] as int;
      return id;
    }
    return -1;
  }

  Future<void> inserirNome(String nome) async {
    final database = await instance.database;
    late final int? id;
    await database.transaction((txn) async {
      await txn.insert(
        'fichas',
        {'nomePersonagem': nome},
      );
    });
    id = await buscarIdPorNome(nome);
    await criarTabelaTalentos(id);
  }

  Future<void> inserirCaracteristica(String nome, String caracteristica) async {
    final database = await instance.database;

    await database.insert(
      nome,
      {'caracteristica': caracteristica},
    );
  }

  Future<void> deletarFicha(int id, tabelaTalentos) async {
    final database = await DB.instance.database;
    final fichaNome = 'table_$tabelaTalentos';
    await database.delete(fichaNome);
    await database.delete(
      'fichas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Ficha>> getAllNomes() async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> nomeList = await database.query('fichas');
    return nomeList
        .map((nome) => Ficha(
            id: nome['id'] as int, nome: nome['nomePersonagem'] as String))
        .toList();
  }
}
