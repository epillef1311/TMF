import 'package:app/database/db.dart';

class Magia {
  final int id;
  String? _nomeMagia = '';
  String? _alvoArea = '';
  String? _tempoExec = '';
  String? _escola = '';
  String? _duracao = '';
  String? _alcance = '';
  String? _testeResistencia = '';
  late int? _memorizada;
  String? _descricao = '';
  String? _nivel = '';

  Magia({required this.id});

  Future loadMagia(int idFicha, int idMagia) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
    SELECT magias.nome_magia, magias.alvo_area, magias.tempo_execucao, magias.escola, magias.duracao, magias.alcance,
    magias.teste_resistencia, magias.memorizada, magias.descricao, magias.nivel_magia
    FROM magias
    INNER JOIN magia_ficha ON magias.id = magia_ficha.id_magia
    WHERE magia_ficha.id_ficha = ?
    AND magias.id = ?;
    ''', [idFicha, idMagia]);

    if (maps.isNotEmpty) {
      final row = maps[0];
      _nomeMagia = row['nome_magia'];
      _alvoArea = row['alvo_area'];
      _tempoExec = row['tempo_execucao'];
      _escola = row['escola'];
      _duracao = row['duracao'];
      _alcance = row['alcance'];
      _testeResistencia = row['teste_resistencia'];
      _memorizada = row['memorizada'];
      _descricao = row['descricao'];
      _nivel = row['nivel_magia'];
    }
  }

  get nomeMagia => _nomeMagia;

  set nomeMagia(value) => _nomeMagia = value;

  get alvoArea => _alvoArea;

  set alvoArea(value) => _alvoArea = value;

  get tempoExec => _tempoExec;

  set tempoExec(value) => _tempoExec = value;

  get escola => _escola;

  set escola(value) => _escola = value;

  get duracao => _duracao;

  set duracao(value) => _duracao = value;

  get alcance => _alcance;

  set alcance(value) => _alcance = value;

  get testeResistencia => _testeResistencia;

  set testeResistencia(value) => _testeResistencia = value;

  get memorizada => _memorizada;

  set memorizada(value) => _memorizada = value;

  get descricao => _descricao;

  set descricao(value) => _descricao = value;

  get nivel => _nivel;

  set nivel(value) => _nivel = value;
}
