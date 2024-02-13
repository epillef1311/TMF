import 'package:app/database/db.dart';
import 'package:app/database/models/Armadura.dart';
import 'package:app/database/models/classe.dart';
import 'package:app/database/models/habilidades.dart';
import 'package:app/database/models/magia.dart';
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
  List<Magia> magias = [];
  List<int> idMagias = [];
  late ArmaduraEscudo armaduraEscudo;

  Ficha({
    required this.id,
    required this.nome,
  });

  Future<Ficha?> loadFicha(int id) async {
    await buscarClassesPorIdFicha(id);
    await buscarIdMagia(id);
    int idHabilidade = await buscarIdHabilidade(id);
    habilidades = Habilidades(idHabilidades: idHabilidade);
    habilidades.loadHabilidades(idHabilidade);
    sumAll(classes);

    int idArmadura = await buscarIdArmadura(id);
    armaduraEscudo = ArmaduraEscudo(id: idArmadura);
    armaduraEscudo.loadArmadura(armaduraEscudo.id);

    await buscarPericiasPorIdFicha(id);

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

  loadPericias(List<int> listaIdPericias) async {
    pericias = [];
    for (final idPericia in listaIdPericias) {
      final pericia = Pericia(idPericia: idPericia);
      await pericia.loadPericia(id, idPericia);
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
    await loadPericias(periciaIDs);
    for (var i = 0; i < pericias.length; i++) {
      calcularTotalPericia(i);
    }
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

  void atualizarTotalPericias() {
    for (var i = 0; i < pericias.length; i++) {
      calcularTotalPericia(i);
    }
  }

  void atualizarPericiasDestreza(int index) {
    int valorTreinado = 0;
    int penalidadeArmadura = 0;
    if (pericias[index].penalidadeArmadura == 1) {
      penalidadeArmadura =
          armaduraEscudo.getPenalidade + armaduraEscudo.getPenalidadeEscudo;
    }
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    pericias[index].total = (pericias[index].totalOutros +
        _totalLevel +
        valorTreinado +
        habilidades.getModDestreza +
        penalidadeArmadura) as int;
  }

  Future<List<int>> buscarIdMagia(int idFicha) async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'magia_ficha',
      columns: ['id_magia'],
      where: 'id_ficha = ?',
      whereArgs: [idFicha],
    );

    final List<int> magiaIDs = [];
    if (maps.isEmpty) {
      return magiaIDs;
    }
    for (final map in maps) {
      magiaIDs.add(map['id_magia']);
    }
    await loadMagias(magiaIDs);
    return magiaIDs;
  }

  loadMagias(List<int> listaIdMagia) async {
    magias = [];
    for (final int idMagia in listaIdMagia) {
      print(listaIdMagia);
      final magia = Magia(id: idMagia);
      await magia.loadMagia(id, idMagia);
      magias.add(magia);
      print(magias);
    }
  }

  void atualizarTodasDestreza() {
    atualizarPericiasDestreza(0);
    atualizarPericiasDestreza(4);
    atualizarPericiasDestreza(9);
    atualizarPericiasDestreza(11);
    atualizarPericiasDestreza(15);
  }

  void atualizarPericiasCarisma(int index) {
    int valorTreinado = 0;
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    pericias[index].total = (pericias[index].totalOutros +
        _totalLevel +
        valorTreinado +
        habilidades.getModCarisma) as int;
  }

  void atualizarTodasPericiasCarisma() {
    atualizarPericiasCarisma(1);
    atualizarPericiasCarisma(3);
    atualizarPericiasCarisma(7);
    atualizarPericiasCarisma(8);
    atualizarPericiasCarisma(12);
    atualizarPericiasCarisma(14);
    atualizarPericiasCarisma(17);
  }

  void atualizarPericiasSabedoria(int index) {
    int valorTreinado = 0;
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    pericias[index].total = (pericias[index].totalOutros +
        _totalLevel +
        valorTreinado +
        habilidades.getModSabedoria) as int;
  }

  void atualizarTodasPericiasSabedoria() {
    atualizarPericiasSabedoria(6);
    atualizarPericiasSabedoria(13);
    atualizarPericiasSabedoria(16);
    atualizarPericiasSabedoria(19);
    atualizarPericiasSabedoria(20);
  }

  void atualizarPericiasInteligencia(int index) {
    int valorTreinado = 0;
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    pericias[index].total = (pericias[index].totalOutros +
        _totalLevel +
        valorTreinado +
        habilidades.getModInteligencia) as int;
  }

  void atualizarTodasPericiasInteligencia() {
    atualizarPericiasInteligencia(5);
    atualizarPericiasInteligencia(10);
    atualizarPericiasInteligencia(18);
  }

  void atualizarPericiaForca(int index) {
    int valorTreinado = 0;
    int penalidadeArmadura = 0;
    if (pericias[index].penalidadeArmadura == 1) {
      penalidadeArmadura =
          armaduraEscudo.getPenalidade + armaduraEscudo.getPenalidadeEscudo;
    }
    if (pericias[index].treinado == true) {
      valorTreinado = 3;
    }
    pericias[index].total = (pericias[index].totalOutros +
        _totalLevel +
        valorTreinado +
        habilidades.getModForca +
        penalidadeArmadura) as int;
  }

  void calcularTotalPericia(int index) {
    if (pericias[index].atributoModificador == 'CAR') {
      atualizarPericiasCarisma(index);
    } else if (pericias[index].atributoModificador == 'DEX') {
      atualizarPericiasDestreza(index);
    } else if (pericias[index].atributoModificador == 'SAB') {
      atualizarPericiasSabedoria(index);
    } else if (pericias[index].atributoModificador == 'INT') {
      atualizarPericiasInteligencia(index);
    } else {
      atualizarPericiaForca(index);
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
