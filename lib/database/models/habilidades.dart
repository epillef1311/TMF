import 'package:app/database/db.dart';

class Habilidades {
  int idHabilidades;
  int? _forca;
  int? _destreza;
  int? _constituicao;
  int? _inteligencia;
  int? _sabedoria;
  int? _carisma;
  int? _modTempForca;
  int? _modTempDestreza;
  int? _modTempConstituicao;
  int? _modTempInteligencia;
  int? _modTempSabedoria;
  int? _modTempCarisma;
  int? _modTempFortitude;
  int? _modTempReflexo;
  int? _modTempVontade;
  int? _caOutros;
  int? _modTempCA;
  int _modForca = 0;
  int _modDestreza = 0;
  int _modConstituicao = 0;
  int _modInteligencia = 0;
  int _modSabedoria = 0;
  int _modCarisma = 0;
  late int _fortitude;
  late int _reflexo;
  late int _vontade;

  Habilidades({required this.idHabilidades});

  Future loadHabilidades(int idHabilidades) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'habilidades',
      where: 'id = ?',
      whereArgs: [idHabilidades],
    );

    if (maps.isEmpty) {
      return null;
    }
    final Map<String, dynamic> map = maps.first;
    _forca = map['FOR'];
    _destreza = map['DES'];
    _constituicao = map['CONS'];
    _inteligencia = map['INT'];
    _sabedoria = map['SAB'];
    _carisma = map['CAR'];
    _modTempForca = map['mod_temp_FOR'];
    _modTempDestreza = map['mod_temp_DES'];
    _modTempConstituicao = map['mod_temp_CON'];
    _modTempInteligencia = map['mod_temp_INT'];
    _modTempSabedoria = map['mod_temp_SAB'];
    _modTempCarisma = map['mod_temp_CAR'];
    _modTempFortitude = map['mod_temp_FORT'];
    _modTempReflexo = map['mod_temp_REF'];
    _modTempVontade = map['mod_temp_VON'];
    _caOutros = map['CA_outros'];
    _modTempCA = map['CA_temp'];
    return null;
  }

  void setAttribute(dynamic value, dynamic attribute) {
    if (value == '') {
      attribute = null;
    } else {
      attribute = int.parse(value);
    }
  }

  void calcularmodificador(modificador, atributo, modTemp) {
    modificador = (atributo + modTemp - 10) / 2;
  }

  void calcularRestencia(resistencia, atributo, nivel, modTempResis) {
    resistencia = (nivel / 2) + atributo + modTempResis;
  }

  int? get forca => _forca;

  get destreza => _destreza;

  get constituicao => _constituicao;

  get inteligencia => _inteligencia;

  get sabedoria => _sabedoria;

  get carisma => _carisma;

  get modTempForca => _modTempForca;

  get modTempDestreza => _modTempDestreza;

  get modTempConstituicao => _modTempConstituicao;

  get modTempInteligencia => _modTempInteligencia;

  get modTempSabedoria => _modTempSabedoria;

  get modTempCarisma => _modTempCarisma;

  get modTempFortitude => _modTempFortitude;

  get modTempReflexo => _modTempReflexo;

  get modTempVontade => _modTempVontade;

  get caOutros => _caOutros;

  get modTempCA => _modTempCA;

  get modForca => _modForca;

  get modDestreza => _modDestreza;

  get modConstituicao => _modConstituicao;

  get modInteligencia => _modInteligencia;

  get modSabedoria => _modSabedoria;

  get modCarisma => _modCarisma;

  set forca(value) => setAttribute(value, _forca);
  set destreza(value) => setAttribute(value, _destreza);
  set constituicao(value) => setAttribute(value, _constituicao);
  set inteligencia(value) => setAttribute(value, _inteligencia);
  set sabedoria(value) => setAttribute(value, _sabedoria);
  set carisma(value) => setAttribute(value, _carisma);
  set modTempForca(value) => setAttribute(value, _modTempForca);
  set modTempDestreza(value) => setAttribute(value, _modTempDestreza);
  set modTempConstituicao(value) => setAttribute(value, _modTempConstituicao);
  set modTempInteligencia(value) => setAttribute(value, _modTempInteligencia);
  set modTempSabedoria(value) => setAttribute(value, _modTempSabedoria);
  set modTempCarisma(value) => setAttribute(value, _modTempCarisma);
  set modForca(value) => setAttribute(value, _modForca);
  set modDestreza(value) => setAttribute(value, _modDestreza);
  set modConstituicao(value) => setAttribute(value, _modConstituicao);
  set modInteligencia(value) => setAttribute(value, _modInteligencia);
  set modSabedoria(value) => setAttribute(value, _modSabedoria);
  set modCarisma(value) => setAttribute(value, _modCarisma);
}
