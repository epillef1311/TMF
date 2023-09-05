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
    await db.execute(_tabelaTalentos);
    await db.execute(_tabelaTalentoFicha);
    await db.execute(_tabelaPericias);
    await db.execute(_tabelaPericiasFicha);
    await db.execute(_tabelaItens);
    await db.execute(_tabelaItensFicha);
    await db.execute(_tabelaHabilidades);
    await db.execute(_tabelaHabilidadeFicha);
    await db.execute(_tabelaMagias);
    await db.execute(_tabelaMagiaFicha);
    await db.execute(_tabelaClasses);
    await db.execute(_tabelaClasseFicha);
    await db.execute(_tabelaAtaques);
    await db.execute(_tabelaAtaqueFicha);
  }

  String get _fichas => '''
  CREATE TABLE fichas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_personagem TEXT,
    tibar INTEGER,
    tibar_prata INTEGER,
    tibar_ouro INTEGER,
    tibar_platina INTEGER,
    xp_tual INTEGER, 
    ponto_acao INTEGER,
    linguagens TEXT,
    sexo TEXT,
    tendencia TEXT,
    tamanho TEXT,
    resistencia TEXT,
    deslocamento TEXT,
    divindade TEXT,
    bio TEXT,
    imagem TEXT,
    mana_total INTEGER,
    mana_atual INTEGER,
    energia INTEGER
  )
  ''';

  String get _tabelaHabilidades => '''
    CREATE TABLE habilidades(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    FOR INTEGER DEFAULT 10,
    DES INTEGER DEFAULT 10,
    CON INTEGER DEFAULT 10,
    INT INTEGER DEFAULT 10,
    SAB INTEGER DEFAULT 10,
    CAR INTEGER DEFAULT 10,
    mod_temp_FOR INTEGER,
    mod_temp_DES INTEGER,
    mod_temp_CON INTEGER,
    mod_temp_INT INTEGER,
    mod_temp_SAB INTEGER,
    mod_temp_CAR INTEGER,
    mod_temp_FORT TEXT,
    mod_temp_REF TEXT,
    mod_temp_VON TEXT,
    CA_outros INTEGER,
    CA_temp INTEGER
)''';

  String get _tabelaHabilidadeFicha => '''
    CREATE TABLE habilidade_ficha (
    id_ficha INTEGER,
    id_habilidade INTEGER,
    FOREIGN KEY(id_ficha) REFERENCES fichas(id),
    FOREIGN KEY(id_habilidade) REFERENCES habilidades(id)
    )
''';

  String get _tabelaTalentos => '''
      CREATE TABLE talento (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_talento TEXT,
      descricao TEXT,
      pre_requisito TEXT,
      especial TEXT,
      livro TEXT,
      saved TEXT
      )
    ''';

  String get _tabelaTalentoFicha => '''
      CREATE TABLE talento_ficha (
        id_ficha INTEGER,
        id_talento INTEGER,
        FOREIGN KEY(id_ficha) REFERENCES fichas(id),
        FOREIGN KEY(id_talento) REFERENCES talento(id)
        )
    ''';

  String get _tabelaPericias => '''
      CREATE TABLE pericias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_pericia TEXT,
        somente_treinado INTEGER,
        penalidade_armadura INTEGER
        );
      
      INSERT INTO pericias (nome_pericia, somente_treinado, penalidade_armadura)
      VALUES
      ( 'Adestrar_Animais', 1, 0),
      ( 'Acrobacia', 0, 1),
      ( 'Atletismo', 0, 1),
      ( 'Atuação', 0, 0),
      ( 'Cavalgar', 0, 0),
      ( 'Conhecimento', 1, 0),
      ( 'Cura', 0, 0),
      ( 'Diplomacia', 0, 0),
      ( 'Enganação', 0, 0),
      ( 'Furtividade', 0, 1),
      ( 'Identificar Magia', 1, 0),
      ( 'Iniciativa', 0, 0),
      ( 'Intimidação', 0, 0),
      ( 'Intuição', 0, 0),
      ( 'Jogatina', 0, 0),
      ( 'Ladinagem', 1, 1),
      ( 'Meditação', 0, 0),
      ( 'Obter_Informação', 0, 0),
      ( 'Ofício', 0, 0),
      ( 'Percepção', 0, 0),
      ( 'Sobrevivência', 0, 0)
    ''';

  String get _tabelaPericiasFicha => '''
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
    ''';

  String get _tabelaItens => '''
      CREATE TABLE itens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_item TEXT,
        quantidade_item REAL,
        peso_item REAL,
        descricao_item TEXT
        )
    ''';

  String get _tabelaItensFicha => '''
      CREATE TABLE itens_ficha (
        id_ficha INTEGER,
        id_item INTEGER,
        FOREIGN KEY(id_ficha) REFERENCES fichas(id),
        FOREIGN KEY(id_item) REFERENCES itens(id)
        )
    ''';

  String get _tabelaMagias => '''
    CREATE TABLE magias(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_magia TEXT,
      alvo_area TEXT,
      tempo_execucao TEXT,
      escola TEXT,
      duracao TEXT,
      alcance TEXT,
      teste_resistencia TEXT,
      memorizada INTEGER,
      descricao TEXT
    )
''';

  String get _tabelaMagiaFicha => '''
    CREATE TABLE magia_fica(
        id_ficha INTEGER,
        id_magia INTEGER,
        FOREIGN KEY(id_ficha) REFERENCES fichas(id),
        FOREIGN KEY(id_magia) REFERENCES magias(id)
    )
''';

  String get _tabelaClasses => '''
    CREATE TABLE classes(
      id INTEGER PRIMARY KEY,
      nome_classe TEXT,
      pv_classe INTEGER,
      bba_classe INTEGER,
      pv_temp INTEGER
    )
''';

  String get _tabelaClasseFicha => '''
    CREATE TABLE classe_ficha(
      id_ficha INTEGER,
      id_classe INTEGER,
      FOREIGN KEY(id_ficha) REFERENCES fichas(id),
      FOREIGN KEY(id_classe) REFERENCES classes(id)
    )
''';

  String get _tabelaAtaques => '''
    CREATE TABLE ataques(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_ataque TEXT,
      bonus_ataque INTEGER,
      dano TEXT,
      critico TEXT,
      alcance TEXT,
      tipo TEXT
    )
''';

  String get _tabelaAtaqueFicha => '''
    CREATE TABLE ataque_ficha(
      id_ficha INTEGER,
      id_ataque INTEGER,
      FOREIGN KEY(id_ficha) REFERENCES fichas(id),
      FOREIGN KEY(id_ataque) REFERENCES ataques(id)
    )
''';

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
    await database.transaction((txn) async {
      await txn.insert(
        'fichas',
        {'nome_personagem': nome},
      );
    });
  }

  Future<void> inserirCaracteristica(String nome, String caracteristica) async {
    final database = await instance.database;
    await database.insert(
      nome,
      {'caracteristica': caracteristica},
    );
  }

  Future<void> deletarFicha(int id) async {
    final database = await DB.instance.database;
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
