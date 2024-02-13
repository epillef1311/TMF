import 'package:app/database/db.dart';

class BonusPericia {
  final int idBonus;
  final int idPericiaFicha;
  late int _bonus;
  late String _origem;

  BonusPericia({required this.idBonus, required this.idPericiaFicha});

  Future loadBonusPericia(int idPericiaFicha, int idBonusOutro) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
    SELECT pericias_outros.bonus, pericias_outros.origem
    FROM pericias_outros
    WHERE pericias_outros.id_pericia_ficha = ?
    AND pericias_outros.id = ?;

''', [idPericiaFicha, idBonusOutro]);

    if (maps.isNotEmpty) {
      final row = maps[0];
      _bonus = row['bonus'];
      _origem = row['origem'];
    }
  }

  int get getBonus => _bonus;

  setBonus(int bonus) => _bonus = bonus;

  String get getOrigem => _origem;

  setOrigem(String origem) => _origem = origem;
}
