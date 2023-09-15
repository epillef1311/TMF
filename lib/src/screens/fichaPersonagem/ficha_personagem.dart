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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('ficha')],
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
                        child: Visibility(
                          visible: ficha.classes.length < 4,
                          child: FloatingActionButton(
                            onPressed: () async {
                              if (ficha.classes.length < 4) {
                                int idClasse = await createNewClass(ficha.id);
                                Classe newClasse = Classe(idClasse: idClasse);
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
                      ),
                    ],
                    // ATRIBUTOS------------------------------------------------
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        RectangleBox(
                          width: 68,
                          nomeColuna: '',
                          id: -1,
                          initialValue: '',
                          tableName: '',
                          hintText: 'FOR',
                          enabled: false,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
