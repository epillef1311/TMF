class Ficha {
  final int id;
  final String nome;
  final String tabelaTalentos;
  final String tabelaPericias;
  final String tabelaItens;
  final String tabelaAtributos;

  Ficha({
    required this.id,
    required this.nome,
  })  : tabelaPericias = 'table_Pericias_$id',
        tabelaAtributos = 'table_Atributos_$id',
        tabelaItens = 'table_Itens_$id',
        tabelaTalentos = 'table_Talentos_$id';
}
