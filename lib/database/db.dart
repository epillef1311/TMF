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
    nome_personagem TEXT,
    tibar INTEGER,
    tibar_prata INTEGER,
    tibar_ouro INTEGER,
    tibar_platina INTEGER,
    xp_tual INTEGER
  )
  ''';

  Future<void> criarTabelaTalentos(int id) async {
    final database = await instance.database;

    await database.execute('''
      CREATE TABLE talento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_talento TEXT,
        descricao TEXT,
        pre_requisito TEXT,
        especial TEXT,
        livro TEXT,
        saved TEXT
        )
    ''');
  }

  Future<void> criarTabelaTalento_ficha(int id) async {
    final database = await instance.database;

    await database.execute('''
      CREATE TABLE talento_ficha (
        id_ficha INTEGER,
        id_talento INTEGER,
        FOREIGN KEY(id_ficha) REFERENCES fichas(id),
        FOREIGN KEY(id_talento) REFERENCES talento(id)
        )
    ''');
  }

  Future<void> criarTabelaPericias(int id) async {
    final database = await instance.database;

    await database.execute('''
      CREATE TABLE pericias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_pericia TEXT,
        somente_treinado TEXT,
        penalidade_armadura TEXT,
        )
    ''');

    await database.execute('''
    INSERT INTO pericias (nome_pericia, somente_treinado, penalidade_armadura)
    VALUES
    ( Adestrar Animais, s, n),
    ( Acrobacia, n, s),
    ( Atletismo, n, s),
    ( Atuação, n, n),
    ( Cavalgar, n, n),
    ( Conhecimento, s, n),
    ( Cura, n, n),
    ( Diplomacia, n, n),
    ( Enganação, n, n),
    ( Furtividade, n, s),
    ( Identificar Magia, s, n),
    ( Iniciativa, n, n),
    ( Intimidação, n, n),
    ( Intuição, n, n),
    ( Jogatina, n, n),
    ( Ladinagem, s, s),
    ( Meditação, n, n),
    ( Obter Informação, n, n),
    ( Ofício, n, n),
    ( Percepção, n, n),
    ( Sobrevivência, n, n)
''');
  }

  Future<void> criarTabelaPericias_ficha(int id) async {
    final database = await instance.database;

    await database.execute('''
      CREATE TABLE pericias_ficha (
        id_ficha INTEGER,
        id_pericia INTEGER,
        treinado INTEGER DEFAULT 0,
        mod_temp_pericia INTEGER DEFAULT 0,
        mod_outros_pericia INTEGER DEFAULT 0,
        opcoes_pericias TEXT,
        FOREIGN KEY(id_ficha) REFERENCES fichas(id),
        FOREIGN KEY(id_pericia) REFERENCES pericias(id)
        )
    ''');
  }

  Future<void> criarTabelaAtributos(int id) async {
    final database = await instance.database;
    final tableName = 'table_Atributos_$id';

    await database.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        valor INTEGER,
        temporario INTEGER 
        )
    ''');

    await database.execute('''
      INSERT INTO $tableName (nome, valor, temporario)
      VALUES
      ('FOR',10,0),
      ('DES',10,0),
      ('CON',10,0),
      ('INT',10,0),
      ('SAB',10,0),
      ('CAR',10,0),

''');
  }

  Future<void> criarTabelaItens(int id) async {
    final database = await instance.database;
    final tableName = 'table_Itens_$id';

    await database.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_item TEXT,
        quantidade_item REAL,
        peso_item REAL,
        descricao_item TEXT
        )
    ''');
  }

//------------------------------------------------------------------------------

  Future<int> buscarIdPorNome(String nome) async {
    final database = await DB.instance.database;
    final result = await database.query(
      'fichas',
      where: 'nome_personagem = ?',
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
        {'nome_personagem': nome},
      );
    });
    id = await buscarIdPorNome(nome);
    await criarTabelaTalentos(id);
    await criarTabelaPericias(id);
    await criarTabelaAtributos(id);
    await criarTabelaItens(id);
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
    final fichaNome = tabelaTalentos;
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
            id: nome['id'] as int, nome: nome['nome_personagem'] as String))
        .toList();
  }
}
