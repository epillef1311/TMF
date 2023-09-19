import 'package:app/database/db.dart';

class Pericia {
  int idPericia;
  late int treinado;
  late int modTempPericia;
  late int modOutrosPericia;
  late String? opcoes;
  late String nomePericia;
  late int somenteTreinado;
  late int penalidadeArmadura;

  Pericia({required this.idPericia});

  Future loadPericia(int idFicha, int idPericia) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
      SELECT pericias.nome_pericia, pericias.somente_treinado, pericias.penalidade_armadura,
             pericias_ficha.treinado, pericias_ficha.mod_temp_pericia, pericias_ficha.mod_outros_pericia, pericias_ficha.opcoes_pericias
      FROM pericias
      INNER JOIN pericias_ficha ON pericias.id = pericias_ficha.id_pericia
      WHERE pericias_ficha.id_ficha = ?
      AND pericias.id = ?;
    ''', [idFicha, idPericia]);

    if (maps.isNotEmpty) {
      final row = maps[0];
      treinado = row['treinado'];
      modTempPericia = row['mod_temp_pericia'];
      modOutrosPericia = row['mod_outros_pericia'];
      opcoes = row['opcoes_pericias'];
      nomePericia = row['nome_pericia'];
      somenteTreinado = row['somente_treinado'];
      penalidadeArmadura = row['penalidade_armadura'];
    }
  }
}
