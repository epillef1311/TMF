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
  int _totalFor = 0;
  int _totalDestreza = 0;
  int _totalConstituicao = 0;
  int _totalInteligencia = 0;
  int _totalSabedoria = 0;
  int _totalCarisma = 0;

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
    _constituicao = map['CON'];
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
    setAllTotalAtributes();
    setAllMods();
    return null;
  }

  void setAttribute(dynamic value, dynamic attribute) {
    if (value == '') {
      attribute = null;
    } else {
      attribute = int.parse(value);
    }
  }

  int calcularmodificador(int atributo, modTemp) {
    modTemp ??= 0;
    return (atributo + modTemp - 10) ~/ 2;
  }

  void calcularRestencia(resistencia, atributo, nivel, modTempResis) {
    resistencia = (nivel / 2) + atributo + modTempResis;
  }

  void setAllMods() {
    setModForca();
    setModDestreza();
    setModConstituicao();
    setModInteligencia();
    setModSabedoria();
    setModCarisma();
  }

  void setAllTotalAtributes() {
    setTotalForca();
    setTotalDestreza();
    setTotalConstituicao();
    setTotalInteligencia();
    setTotalSabedoria();
    setTotalCarisma();
  }

  get getForca => _forca;
  get getDestreza => _destreza;
  get getConstituicao => _constituicao;
  get getInteligencia => _inteligencia;
  get getSabedoria => _sabedoria;
  get getCarisma => _carisma;
  get getModTempForca => _modTempForca;
  get getModTempDestreza => _modTempDestreza;
  get getModTempConstituicao => _modTempConstituicao;
  get getModTempInteligencia => _modTempInteligencia;
  get getModTempSabedoria => _modTempSabedoria;
  get getModTempCarisma => _modTempCarisma;
  get getModTempFortitude => _modTempFortitude;
  get getModTempReflexo => _modTempReflexo;
  get getModTempVontade => _modTempVontade;
  get getCaOutros => _caOutros;
  get getModTempCA => _modTempCA;
  get getModForca => _modForca;
  get getModDestreza => _modDestreza;
  get getModConstituicao => _modConstituicao;
  get getModInteligencia => _modInteligencia;
  get getModSabedoria => _modSabedoria;
  get getModCarisma => _modCarisma;
  get getTotalForca => _totalFor;
  get getTotalDestreza => _totalDestreza;
  get getTotalConstituicao => _totalConstituicao;
  get getTotalInteligencia => _totalInteligencia;
  get getTotalSabedoria => _totalSabedoria;
  get getTotalCarisma => _totalCarisma;

  void setForca(value) {
    if (value == '') {
      _forca = 0;
    } else {
      _forca = int.parse(value);
    }
  }

  void setDestreza(value) {
    if (value == '') {
      _destreza = 0;
    } else {
      _destreza = int.parse(value);
    }
  }

  void setConstituicao(value) {
    if (value == '') {
      _constituicao = 0;
    } else {
      _constituicao = int.parse(value);
    }
  }

  void setInteligencia(value) {
    if (value == '') {
      _inteligencia = 0;
    } else {
      _inteligencia = int.parse(value);
    }
  }

  void setSabedoria(value) {
    if (value == '') {
      _sabedoria = 0;
    } else {
      _sabedoria = int.parse(value);
    }
  }

  void setCarisma(value) {
    if (value == '') {
      _carisma = 0;
    } else {
      _carisma = int.parse(value);
    }
  }

  void setModTempForca(value) {
    if (value == '') {
      _modTempForca = 0;
    } else {
      _modTempForca = int.parse(value);
    }
  }

  void setModTempDestreza(value) {
    if (value == '') {
      _modTempDestreza = 0;
    } else {
      _modTempDestreza = int.parse(value);
    }
  }

  void setModTempConstituicao(value) {
    if (value == '') {
      _modTempConstituicao = 0;
    } else {
      _modTempConstituicao = int.parse(value);
    }
  }

  void setModTempInteligencia(value) {
    if (value == '') {
      _modTempInteligencia = 0;
    } else {
      _modTempInteligencia = int.parse(value);
    }
  }

  void setModTempSabedoria(value) {
    if (value == '') {
      _modTempSabedoria = 0;
    } else {
      _modTempSabedoria = int.parse(value);
    }
  }

  void setModTempCarisma(value) {
    if (value == '') {
      _modTempCarisma = 0;
    } else {
      _modTempCarisma = int.parse(value);
    }
  }

  void setModForca() {
    final int value = calcularmodificador(getForca, getModTempForca);
    _modForca = value;
  }

  void setModDestreza() {
    final int value = calcularmodificador(getDestreza, getModTempDestreza);
    _modDestreza = value;
  }

  void setModConstituicao() {
    final int value =
        calcularmodificador(getConstituicao, getModTempConstituicao);
    _modConstituicao = value;
  }

  void setModInteligencia() {
    final int value =
        calcularmodificador(getInteligencia, getModTempInteligencia);
    _modInteligencia = value;
  }

  void setModSabedoria() {
    final int value = calcularmodificador(getSabedoria, getModTempSabedoria);
    _modSabedoria = value;
  }

  void setModCarisma() {
    final int value = calcularmodificador(getCarisma, getModTempCarisma);
    _modCarisma = value;
  }

  void setTotalForca() {
    _totalFor = getForca + getModTempForca;
  }

  void setTotalDestreza() {
    _totalDestreza = getDestreza + getModTempDestreza;
  }

  void setTotalConstituicao() {
    _totalConstituicao = getConstituicao + getModTempConstituicao;
  }

  void setTotalInteligencia() {
    _totalInteligencia = getInteligencia + getModTempInteligencia;
  }

  void setTotalSabedoria() {
    _totalSabedoria = getSabedoria + getModTempSabedoria;
  }

  void setTotalCarisma() {
    _totalCarisma = getCarisma + getModTempCarisma;
  }
}
