import 'package:app/database/db.dart';

class Classe {
  final int idClasse;
  int? _nivel;
  String? _nome;
  int? _pv;
  int? _bba;

  Classe({required this.idClasse});

  Future loadClasse(int idClasse) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'classes',
      where: 'id = ?',
      whereArgs: [idClasse],
    );

    if (maps.isEmpty) {
      return null;
    }
    final Map<String, dynamic> map = maps.first;
    _nivel = map['nivel'];
    _nome = map['nome_classe'];
    _pv = map['pv_classe'];
    _bba = map['bba_classe'];
    return null;
  }

  get getIdClasse => idClasse;

  get getNivel => _nivel;

  void setNivel(nivel) {
    if (nivel == '') {
      _nivel == null;
    } else {
      _nivel = int.parse(nivel);
    }
  }

  get getNome => _nome;

  void setNome(nome) => _nome = nome;

  get getPv => _pv;

  void setPv(pv) {
    if (pv == '') {
      _pv == null;
    } else {
      _pv = int.parse(pv);
    }
  }

  get getBba => _bba;

  void setBba(bba) {
    if (bba == '') {
      _bba == null;
    } else {
      _bba = int.parse(bba);
    }
  }
}
