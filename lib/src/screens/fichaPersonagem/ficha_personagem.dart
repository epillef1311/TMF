import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/fichaWidget/Text_field.dart';
import 'package:app/database/db.dart';
import 'package:app/database/models/classe.dart';
import 'package:app/database/models/ficha.dart';
import 'package:flutter/material.dart';

class FichaPersonagem extends StatefulWidget {
  final Ficha ficha;
  int totalValue = 0;

  FichaPersonagem({Key? key, required this.ficha}) : super(key: key);

  @override
  State<FichaPersonagem> createState() => _FichaPersonagemState();
}

class _FichaPersonagemState extends State<FichaPersonagem> {
  TextEditingController valorTotal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ficha = ModalRoute.of(context)!.settings.arguments as Ficha;
    print('rebuild');
    return Scaffold(
        backgroundColor: SetColors.backGroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Atributos')],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: SetColors.primaryRedColor,
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 354,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 234,
                          nomeColuna: 'nome_personagem',
                          id: ficha.id,
                          initialValue: ficha.nome,
                          tableName: 'fichas',
                          hintText: 'nome do personagem',
                          onChanged: (value) {
                            ficha.setNome(value);
                          },
                        ),
                        RectangleBox(
                          width: 110,
                          nomeColuna: 'sexo',
                          id: ficha.id,
                          initialValue: ficha.getSexo,
                          tableName: 'fichas',
                          hintText: 'sexo',
                          onChanged: (value) {
                            ficha.setSexo(value);
                          },
                        )
                      ],
                    ),
                  ),
                  // RAÇA
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 112,
                          nomeColuna: 'raca',
                          id: ficha.id,
                          initialValue: ficha.getRaca,
                          tableName: 'fichas',
                          hintText: 'raça',
                          onChanged: (value) {
                            ficha.setRaca(value);
                          },
                        ),
                        RectangleBox(
                          width: 112,
                          nomeColuna: 'tendencia',
                          id: ficha.id,
                          initialValue: ficha.getTendencia,
                          tableName: 'fichas',
                          hintText: 'tendência',
                          onChanged: (value) {
                            ficha.setTendencia(value);
                          },
                        ),
                        RectangleBox(
                          width: 112,
                          nomeColuna: 'linguagens',
                          id: ficha.id,
                          initialValue: ficha.getLinguagens,
                          tableName: 'fichas',
                          hintText: 'linguagens',
                          onChanged: (value) {
                            ficha.setLinguagens(value);
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RectangleBox(
                        width: 174,
                        nomeColuna: 'divindade',
                        id: ficha.id,
                        initialValue: ficha.getDivindade,
                        tableName: 'fichas',
                        hintText: 'divindade',
                        onChanged: (value) {
                          ficha.setDivindade(value);
                        },
                      ),
                      RectangleBox(
                        width: 174,
                        nomeColuna: 'tamanho',
                        id: ficha.id,
                        initialValue: ficha.getTamanho,
                        tableName: 'fichas',
                        hintText: 'tamanho',
                        onChanged: (value) {
                          ficha.setTamanho(value);
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'NV',
                          style: TextStyle(
                            color: SetColors.primaryRedColor,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Classes',
                          style: TextStyle(
                            color: SetColors.primaryRedColor,
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 72),
                          child: Text(
                            'BBA',
                            style: TextStyle(
                              color: SetColors.primaryRedColor,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          'PV',
                          style: TextStyle(
                            color: SetColors.primaryRedColor,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      ListView.builder(
                          itemCount: ficha.classes.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SquareBox(
                                    nomeColuna: 'nivel',
                                    id: ficha.classes[index].getIdClasse,
                                    initialValue: ficha.classes[index].getNivel,
                                    tableName: 'classes',
                                    onChanged: (value) {
                                      ficha.classes[index].setNivel(value);
                                      ficha.sumClassLevel(ficha.classes);
                                      setState(() {});
                                    },
                                  ),
                                  RectangleBox(
                                      width: 172,
                                      nomeColuna: 'nome_classe',
                                      id: ficha.classes[index].getIdClasse,
                                      initialValue:
                                          ficha.classes[index].getNome,
                                      tableName: 'classes',
                                      hintText: 'nome da classe',
                                      onChanged: (value) {
                                        ficha.classes[index].setNome(value);
                                      }),
                                  SquareBox(
                                    nomeColuna: 'bba_classe',
                                    id: ficha.classes[index].getIdClasse,
                                    initialValue: ficha.classes[index].getBba,
                                    tableName: 'classes',
                                    onChanged: (value) {
                                      ficha.classes[index].setBba(value);
                                      ficha.sumClassBba(ficha.classes);
                                      setState(() {});
                                    },
                                  ),
                                  SquareBox(
                                    nomeColuna: 'pv_classe',
                                    id: ficha.classes[index].getIdClasse,
                                    initialValue: ficha.classes[index].getPv,
                                    tableName: 'classes',
                                    onChanged: (value) {
                                      ficha.classes[index].setPv(value);
                                      ficha.sumClassPv(ficha.classes);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                      // TOTAL------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SquareBox(
                              nomeColuna: 'nivel',
                              id: ficha.classes[0].getIdClasse,
                              initialValue: ficha.getTotalLevel,
                              tableName: 'classes',
                              enabled: false,
                            ),
                            RectangleBox(
                              width: 172,
                              nomeColuna: 'nome_classe',
                              id: ficha.classes[0].getIdClasse,
                              initialValue: null,
                              tableName: 'classes',
                              hintText: 'Total',
                              onChanged: (value) {},
                              enabled: false,
                            ),
                            SquareBox(
                              nomeColuna: 'bba_classe',
                              id: ficha.classes[0].getIdClasse,
                              initialValue: ficha.getTotalBba,
                              tableName: 'classes',
                              enabled: false,
                            ),
                            SquareBox(
                              nomeColuna: 'pv_classe',
                              id: ficha.classes[0].getIdClasse,
                              initialValue: ficha.getTotalPv,
                              tableName: 'classes',
                              enabled: false,
                            ),
                          ],
                        ),
                      ),
                      // CREATE NEW CLASSE--------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: ficha.classes.length < 4,
                              child: FloatingActionButton(
                                onPressed: () async {
                                  if (ficha.classes.length < 4) {
                                    int idClasse =
                                        await createNewClass(ficha.id);
                                    Classe newClasse =
                                        Classe(idClasse: idClasse);
                                    ficha.classes.add(newClasse);
                                    ficha.sumAll(ficha.classes);
                                    setState(() {});
                                  }
                                },
                                mini: true,
                                backgroundColor: SetColors.primaryRedColor,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    // ATRIBUTOS------------------------------------------------
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Habilidade',
                          style: TextStyle(
                              fontSize: 14, color: SetColors.secondaryRedColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text('Total',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: SetColors.secondaryRedColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Valor',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: SetColors.secondaryRedColor)),
                        ),
                        Text('Mod.Hab',
                            style: TextStyle(
                                fontSize: 14,
                                color: SetColors.secondaryRedColor)),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text('Temp',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: SetColors.secondaryRedColor)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: 'habilidades',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'FOR',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getTotalForca,
                          tableName: '',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: 'FOR',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getForca,
                          tableName: 'habilidades',
                          onChanged: (value) {
                            ficha.habilidades.setForca(value);
                            ficha.habilidades.setTotalForca();
                            ficha.habilidades.setModForca();
                            setState(() {});
                          },
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getModForca,
                          tableName: 'habilidades',
                          enabled: false,
                        ),
                        SquareBox(
                            nomeColuna: 'mod_temp_FOR',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getModTempForca,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setModTempForca(value);
                              ficha.habilidades.setTotalForca();
                              ficha.habilidades.setModForca();
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: 'habilidades',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'DES',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getTotalDestreza,
                          tableName: '',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: 'DES',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getDestreza,
                          tableName: 'habilidades',
                          onChanged: (value) {
                            ficha.habilidades.setDestreza(value);
                            ficha.habilidades.setTotalDestreza();
                            ficha.habilidades.setModDestreza();
                            setState(() {});
                          },
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getModDestreza,
                          tableName: 'habilidades',
                          enabled: false,
                        ),
                        SquareBox(
                            nomeColuna: 'mod_temp_DES',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getModTempDestreza,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setModTempDestreza(value);
                              ficha.habilidades.setTotalDestreza();
                              ficha.habilidades.setModDestreza();
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RectangleBox(
                            width: 68,
                            nomeColuna: 'habilidades',
                            id: -1,
                            initialValue: '',
                            tableName: '',
                            hintText: 'CON',
                            enabled: false,
                          ),
                          SquareBox(
                            nomeColuna: '',
                            id: ficha.habilidades.idHabilidades,
                            initialValue:
                                ficha.habilidades.getTotalConstituicao,
                            tableName: '',
                            enabled: false,
                          ),
                          SquareBox(
                            nomeColuna: 'CON',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getConstituicao,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setConstituicao(value);
                              ficha.habilidades.setTotalConstituicao();
                              ficha.habilidades.setModConstituicao();
                              setState(() {});
                            },
                          ),
                          SquareBox(
                            nomeColuna: '',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getModConstituicao,
                            tableName: 'habilidades',
                            enabled: false,
                          ),
                          SquareBox(
                              nomeColuna: 'mod_temp_CON',
                              id: ficha.habilidades.idHabilidades,
                              initialValue:
                                  ficha.habilidades.getModTempConstituicao,
                              tableName: 'habilidades',
                              onChanged: (value) {
                                ficha.habilidades.setModTempConstituicao(value);
                                ficha.habilidades.setTotalConstituicao();
                                ficha.habilidades.setModConstituicao();
                                setState(() {});
                              })
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: 'habilidades',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'INT',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getTotalInteligencia,
                          tableName: '',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: 'INT',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getInteligencia,
                          tableName: 'habilidades',
                          onChanged: (value) {
                            ficha.habilidades.setInteligencia(value);
                            ficha.habilidades.setTotalInteligencia();
                            ficha.habilidades.setModInteligencia();
                            setState(() {});
                          },
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getModInteligencia,
                          tableName: 'habilidades',
                          enabled: false,
                        ),
                        SquareBox(
                            nomeColuna: 'mod_temp_INT',
                            id: ficha.habilidades.idHabilidades,
                            initialValue:
                                ficha.habilidades.getModTempInteligencia,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setModTempInteligencia(value);
                              ficha.habilidades.setTotalInteligencia();
                              ficha.habilidades.setModInteligencia();
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: 'habilidades',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'SAB',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getTotalSabedoria,
                          tableName: '',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: 'SAB',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getSabedoria,
                          tableName: 'habilidades',
                          onChanged: (value) {
                            ficha.habilidades.setSabedoria(value);
                            ficha.habilidades.setTotalSabedoria();
                            ficha.habilidades.setModSabedoria();
                            setState(() {});
                          },
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getModSabedoria,
                          tableName: 'habilidades',
                          enabled: false,
                        ),
                        SquareBox(
                            nomeColuna: 'mod_temp_SAB',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getModTempSabedoria,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setModTempSabedoria(value);
                              ficha.habilidades.setTotalSabedoria();
                              ficha.habilidades.setModSabedoria();
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: 'habilidades',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'CAR',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getTotalCarisma,
                          tableName: '',
                          enabled: false,
                        ),
                        SquareBox(
                          nomeColuna: 'CAR',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getCarisma,
                          tableName: 'habilidades',
                          onChanged: (value) {
                            ficha.habilidades.setCarisma(value);
                            ficha.habilidades.setTotalCarisma();
                            ficha.habilidades.setModCarisma();
                            setState(() {});
                          },
                        ),
                        SquareBox(
                          nomeColuna: '',
                          id: ficha.habilidades.idHabilidades,
                          initialValue: ficha.habilidades.getModCarisma,
                          tableName: 'habilidades',
                          enabled: false,
                        ),
                        SquareBox(
                            nomeColuna: 'mod_temp_CAR',
                            id: ficha.habilidades.idHabilidades,
                            initialValue: ficha.habilidades.getModTempCarisma,
                            tableName: 'habilidades',
                            onChanged: (value) {
                              ficha.habilidades.setModTempCarisma(value);
                              ficha.habilidades.setTotalCarisma();
                              ficha.habilidades.setModCarisma();
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
