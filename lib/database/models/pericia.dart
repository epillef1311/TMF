import 'package:app/database/db.dart';

import 'bonus_pericia.dart';

class Pericia {
  final int idPericia;
  late int idPericiaFicha;
  late bool treinado;
  List<BonusPericia> modOutrosPericia = [];
  late String? opcoes;
  late String nomePericia;
  late int somenteTreinado;
  late int penalidadeArmadura;
  int totalOutros = 0;
  int total = 0;
  late String atributoModificador;

  Pericia({required this.idPericia});

  Future loadPericia(int idFicha, int idPericia) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
      SELECT pericias.nome_pericia, pericias.somente_treinado, pericias.penalidade_armadura, pericias.atributo_modificador,
       pericias_ficha.treinado, pericias_ficha.opcoes_pericias, pericias_ficha.id_pericia_ficha
      FROM pericias
      INNER JOIN pericias_ficha ON pericias.id = pericias_ficha.id_pericia
      WHERE pericias_ficha.id_ficha = ?
      AND pericias.id = ?;
    ''', [idFicha, idPericia]);

    if (maps.isNotEmpty) {
      final row = maps[0];
      opcoes = row['opcoes_pericias'];
      nomePericia = row['nome_pericia'];
      somenteTreinado = row['somente_treinado'];
      penalidadeArmadura = row['penalidade_armadura'];
      atributoModificador = row['atributo_modificador'];
      idPericiaFicha = row['id_pericia_ficha'];
      if (row['treinado'] == 1) {
        treinado = true;
      } else {
        treinado = false;
      }
    }
    buscarBonusPorIdPericia(idPericiaFicha);
  }

  /*void setModTempPericia(String modTempPericia) {
    if (modTempPericia == '') {
      this.modTempPericia = 0;
    } else {
      this.modTempPericia = int.parse(modTempPericia);
    }
  }

  void setModOutrosPericia(String modOutrosPericia) {
    if (modOutrosPericia == '') {
      this.modOutrosPericia = 0;
    } else {
      this.modOutrosPericia = int.parse(modOutrosPericia);
    }
  }*/

  void setSomenteTreinado(String somenteTreinado) {
    if (somenteTreinado == '') {
      this.somenteTreinado = 0;
    } else {
      this.somenteTreinado = int.parse(somenteTreinado);
    }
  }

  Future<List<int>> buscarBonusPorIdPericia(int idPericiaFicha) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'pericias_outros',
      columns: ['id'],
      where: 'id_pericia_ficha = ?',
      whereArgs: [idPericiaFicha],
    );

    final List<int> periciaBonusIDs = [];
    for (final map in maps) {
      periciaBonusIDs.add(map['id']);
    }
    await loadBonusOutro(periciaBonusIDs);
    return periciaBonusIDs;
  }

  loadBonusOutro(List<int> listaIdBonus) async {
    modOutrosPericia = [];
    for (final idBonus in listaIdBonus) {
      final bonus =
          BonusPericia(idBonus: idBonus, idPericiaFicha: idPericiaFicha);
      await bonus.loadBonusPericia(idPericiaFicha, idBonus);
      modOutrosPericia.add(bonus);
    }
    somarBonus();
  }

  void somarBonus() {
    totalOutros = 0;
    int temp = totalOutros;
    for (BonusPericia bonus in modOutrosPericia) {
      temp = temp + bonus.getBonus;
    }
    totalOutros = temp;
  }

  /*Future BuscarBonusPorPericiaFichaId(int periciaFichaId) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'pericias_outros',
      columns: ['id_pericia_outro'],
      where: 'id_pericia_ficha = ?',
      whereArgs: [periciaFichaId],
    );

    final List<int> periciaIDs = [];
    for (final map in maps) {
      periciaIDs.add(map['id_pericia_outro']);
    }
    await loadBonusPericias(periciaIDs);
    somarBonus();
    return periciaIDs;
  }

  loadBonusPericias(List<int> listaIdPericias) async {
    pericias = [];
    for (final idPericia in listaIdPericias) {
      final pericia = Pericia(idPericia: idPericia);
      await pericia.loadPericia(id, idPericia);
      pericias.add(pericia);
    }
  }*/
}
