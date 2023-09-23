import 'package:app/database/db.dart';
import 'package:app/database/models/classe.dart';
import 'package:app/database/models/habilidades.dart';
import 'package:app/database/models/pericia.dart';

class Ficha {
  final int id;
  String nome;
  int? _tibar;
  int? _tibarPrata;
  int? _tibarOuro;
  int? _tibarPlatina;
  int? _xpAtual;
  int? _pontoAcao;
  String? _linguagens;
  String? _sexo;
  String? _tendencia;
  String? _tamanho;
  String? _deslocamento;
  String? _divindade;
  String? _bio;
  String? _imagem;
  int? _manaTotal;
  int? _manaAtual;
  int? _energia;
  String? _raca;
  int _totalLevel = 0;
  int _totalBba = 0;
  int _totalPv = 0;
  late Habilidades habilidades;
  List<Pericia> pericias = [];
  List<Classe> classes = [];
  List<int> idClasses = [];

  Ficha({
    required this.id,
    required this.nome,
  });

  Future<Ficha?> loadFicha(int id) async {
    await buscarClassesPorIdFicha(id);
    sumAll(classes);
    int idHabilidade = await buscarIdHabilidade(id);
    habilidades = Habilidades(idHabilidades: idHabilidade);
    habilidades.loadHabilidades(idHabilidade);
    buscarPericiasPorIdFicha(id);
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
    _tibar = map['tibar'];
    _tibarPrata = map['tibar_prata'];
    _tibarOuro = map['tibar_ouro'];
    _tibarPlatina = map['tibar_platina'];
    _xpAtual = map['xp_atual'];
    _pontoAcao = map['ponto_acao'];
    _linguagens = map['linguagens'];
    _sexo = map['sexo'];
    _tendencia = map['tendencia'];
    _tamanho = map['tamanho'];
    _deslocamento = map['deslocamento'];
    _divindade = map['divindade'];
    _bio = map['bio'];
    _imagem = map['imagem'];
    _manaTotal = map['mana_total'];
    _manaAtual = map['mana_atual'];
    _energia = map['energia'];
    _raca = map['raca'];

    return null;
  }

  Future<List<Map<String, dynamic>>> buscarClassesPorIdFicha(
      int idFicha) async {
    final database = await DB.instance.database;

    final List<Map<String, dynamic>> resultados = await database.rawQuery(
      'SELECT * FROM classe_ficha WHERE id_ficha = ?',
      [idFicha],
    );
    await loadClasses(resultados);
    return resultados;
  }

  loadClasses(List<Map<String, dynamic>> listaClasses) {
    classes = [];
    idClasses = [];
    for (final classe in listaClasses) {
      final idClasse = classe['id_classe'];
      final classeFicha = Classe(idClasse: idClasse);

      classeFicha.loadClasse(idClasse);
      if (idClasses.contains(classeFicha.idClasse)) {
        //idClasses.add(classeFicha.idClasse);
        continue;
      } else {
        idClasses.add(classeFicha.idClasse);
        classes.add(classeFicha);
      }
    }
  }

  loadPericias(List<int> listaIdPericias) {
    pericias = [];
    for (final idPericia in listaIdPericias) {
      final pericia = Pericia(idPericia: idPericia);
      pericia.loadPericia(id, idPericia);
      pericias.add(pericia);
    }
  }

  Future<List<int>> buscarPericiasPorIdFicha(int idFicha) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'pericias_ficha',
      columns: ['id_pericia'],
      where: 'id_ficha = ?',
      whereArgs: [idFicha],
    );

    final List<int> periciaIDs = [];
    for (final map in maps) {
      periciaIDs.add(map['id_pericia']);
    }
    loadPericias(periciaIDs);
    /*for (Pericia pericia in pericias) {
      calcularTotalPericia();
    }*/
    return periciaIDs;
  }

  sumClassLevel(List<Classe> classes) {
    int totalLevel = 0;
    for (Classe classe in classes) {
      if (classe.getNivel == null) {
        continue;
      } else {
        totalLevel += classe.getNivel as int;
      }
    }
    _totalLevel = totalLevel;
    return totalLevel;
  }

  sumClassBba(List<Classe> classes) {
    int totalBba = 0;
    for (Classe classe in classes) {
      if (classe.getBba == null) {
        continue;
      } else {
        totalBba += classe.getBba as int;
      }
    }
    _totalBba = totalBba;
    return totalBba;
  }

  void sumClassPv(List<Classe> classes) {
    int totalPv = 0;
    for (Classe classe in classes) {
      if (classe.getPv == null) {
        continue;
      } else {
        totalPv += classe.getPv as int;
      }
    }
    _totalPv = totalPv;
  }

  void sumAll(List<Classe> classes) {
    sumClassBba(classes);
    sumClassLevel(classes);
    sumClassPv(classes);
  }

  void calcularTotalPericia(int index) {
    int valorTreinado = 0;
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    if (pericias[index].atributoModificador == 'FOR') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getForca) as int;
    }

    if (pericias[index].atributoModificador == 'DEX') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getDestreza) as int;
    }
    if (pericias[index].atributoModificador == 'CON') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getConstituicao) as int;
    }
    if (pericias[index].atributoModificador == 'INT') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getInteligencia) as int;
    }
    if (pericias[index].atributoModificador == 'SAB') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getSabedoria) as int;
    }
    if (pericias[index].atributoModificador == 'CAR') {
      pericias[index].total = (pericias[index].modOutrosPericia +
          pericias[index].modTempPericia +
          _totalLevel +
          valorTreinado +
          habilidades.getCarisma) as int;
    }
  }

  // START OF GETTERS AND SETTERS-----------------------------------------------
  String get getNome => nome;

  void setNome(String nome) => this.nome = nome;

  get getTibar => _tibar;

  void setTibar(tibar) {
    if (tibar == '') {
      _tibar == null;
    } else {
      _tibar = int.parse(tibar);
    }
  }

  get getTibarPrata => _tibarPrata;

  void setTibarPrata(tibarPrata) {
    if (tibarPrata == '') {
      _tibarPrata == null;
    } else {
      _tibarPrata = int.parse(tibarPrata);
    }
  }

  get getTibarOuro => _tibarOuro;

  void setTibarOuro(tibarOuro) {
    if (tibarOuro == '') {
      _tibarOuro == null;
    } else {
      _tibarOuro = int.parse(tibarOuro);
    }
  }

  get getTibarPlatina => _tibarPlatina;

  void setTibarPlatina(tibarPlatina) {
    if (tibarPlatina == '') {
      _tibarPlatina == null;
    } else {
      _tibarPlatina = int.parse(tibarPlatina);
    }
  }

  get getXpAtual => _xpAtual;

  void setXpAtual(xpAtual) {
    if (xpAtual == '') {
      _xpAtual == null;
    } else {
      _xpAtual = int.parse(xpAtual);
    }
  }

  get getPontoAcao => _pontoAcao;

  void setPontoAcao(pontoAcao) {
    if (pontoAcao == '') {
      _pontoAcao == null;
    } else {
      _pontoAcao = int.parse(pontoAcao);
    }
  }

  get getLinguagens => _linguagens;

  void setLinguagens(linguagens) => _linguagens = linguagens;

  get getSexo => _sexo;

  void setSexo(sexo) => _sexo = sexo;

  get getTendencia => _tendencia;

  void setTendencia(tendencia) => _tendencia = tendencia;

  get getTamanho => _tamanho;

  void setTamanho(tamanho) => _tamanho = tamanho;

  get getDeslocamento => _deslocamento;

  void setDeslocamento(deslocamento) => _deslocamento = deslocamento;

  get getDivindade => _divindade;

  void setDivindade(divindade) => _divindade = divindade;

  get getBio => _bio;

  void setBio(bio) => _bio = bio;

  get getImagem => _imagem;

  void setImagem(imagem) => _imagem = imagem;

  get getManaTotal => _manaTotal;

  void setManaTotal(manaTotal) {
    if (manaTotal == '') {
      _manaTotal == null;
    } else {
      _manaTotal = int.parse(manaTotal);
    }
  }

  get getManaAtual => _manaAtual;

  void setManaAtual(manaAtual) {
    if (manaAtual == '') {
      _manaAtual == null;
    } else {
      _manaAtual = int.parse(manaAtual);
    }
  }

  get getEnergia => _energia;

  void setEnergia(energia) {
    if (energia == '') {
      _energia == null;
    } else {
      _energia = int.parse(energia);
    }
  }

  get getRaca => _raca;

  void setRaca(raca) => _raca = raca;

  get getTotalLevel => _totalLevel;

  get getTotalBba => _totalBba;

  get getTotalPv => _totalPv;
  //END OF GETTERS AND SETTERS--------------------------------------------------
}
