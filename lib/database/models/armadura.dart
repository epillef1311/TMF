import 'package:app/database/db.dart';

class ArmaduraEscudo {
  int id;
  late String _nomeArmadura;
  late int _bonusCaArmadura;
  late int _maximoDestreza;
  String _tipo = 'nenhum';
  int _penalidadeArmadura = 0;
  String _nomeEscudo = '';
  int _bonusCaEscudo = 0;
  int _penalidadeEscudo = 0;

  ArmaduraEscudo({required this.id});

  loadArmadura(int idArmadura) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'armaduras',
      where: 'id = ?',
      whereArgs: [idArmadura],
    );

    if (maps.isEmpty) {
      return null;
    }

    final Map<String, dynamic> map = maps.first;
    _nomeArmadura = map['nome_armadura'];
    _bonusCaArmadura = map['bonus_ca_armadura'];
    _maximoDestreza = map['maximo_destreza'];
    _tipo = map['tipo_armadura'];
    _penalidadeArmadura = map['penalidade_armadura'];
    _nomeEscudo = map['nome_escudo'];
    _bonusCaEscudo = map['bonus_ca_escudo'];
    _penalidadeEscudo = map['penalidade_escudo'];
  }

//GETTERS AND SETTERS ----------------------------------------------------------
  String get getNomeArmadura => _nomeArmadura;

  set setNomeArmadura(String value) => _nomeArmadura = value;

  get getBonusCA => _bonusCaArmadura;

  setBonusCaArmadura(value) {
    if (value == '') {
      _bonusCaArmadura = 0;
    } else {
      _bonusCaArmadura = int.parse(value);
    }
  }

  get getMaximoDestreza => _maximoDestreza;

  set setMaximoDestreza(value) {
    if (value == '') {
      _maximoDestreza = 0;
    } else {
      _maximoDestreza = int.parse(value);
    }
  }

  get getTipo => _tipo;

  set setTipo(value) => _tipo = value;

  get getPenalidade => _penalidadeArmadura;

  setPenalidadeArmadura(value) {
    if (value == '') {
      _penalidadeArmadura = 0;
    } else {
      _penalidadeArmadura = int.parse(value);
    }
  }

  get getNomeEscudo => _nomeEscudo;

  set setNomeEscudo(String value) => _nomeEscudo = value;

  get getBonusCaEscudo => _bonusCaEscudo;

  setBonusEscudo(value) {
    if (value == '') {
      _bonusCaEscudo = 0;
    } else {
      _bonusCaEscudo = int.parse(value);
    }
  }

  get getPenalidadeEscudo => _penalidadeEscudo;

  setPenalidadeEscudo(value) {
    if (value == '') {
      _penalidadeEscudo = 0;
    } else {
      _penalidadeEscudo = int.parse(value);
    }
  }
}
