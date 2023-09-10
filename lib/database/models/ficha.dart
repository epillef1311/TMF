import 'package:app/database/db.dart';

class Ficha {
  final int id;
  final String nome;
  int? tibar;
  int? tibarPrata;
  int? tibarOuro;
  int? tibarPlatina;
  int? xpAtual;
  int? pontoAcao;
  String? linguagens;
  String? sexo;
  String? tendencia;
  String? tamanho;
  String? deslocamento;
  String? divindade;
  String? bio;
  String? imagem;
  int? manaTotal;
  int? manaAtual;
  int? energia;

  Ficha({
    required this.id,
    required this.nome,
  });

  Future<Ficha?> loadFicha(int id) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'fichas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }
    final Map<String, dynamic> map = maps.first;
    tibar = map['tibar'];
    tibarPrata = map['tibar_prata'];
    tibarOuro = map['tibar_ouro'];
    tibarPlatina = map['tibar_platina'];
    xpAtual = map['xp_atual'];
    pontoAcao = map['ponto_acao'];
    linguagens = map['linguagens'];
    sexo = map['sexo'];
    tendencia = map['tendencia'];
    tamanho = map['tamanho'];
    deslocamento = map['deslocamento'];
    divindade = map['divindade'];
    bio = map['bio'];
    imagem = map['imagem'];
    manaTotal = map['mana_total'];
    manaAtual = map['mana_atual'];
    energia = map['energia'];
    return null;
  }

  Future<void> updateFicha(String column, dynamic value, int id) async {
    final database = await DB.instance.database;

    await database.update(
      'fichas',
      {column: value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
