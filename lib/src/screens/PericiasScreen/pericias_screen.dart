import 'package:app/app/widgets/fichaWidget/Text_field.dart';
import 'package:app/app/widgets/fichaWidget/check_box.dart';
import 'package:app/database/db.dart';
import 'package:app/database/models/ficha.dart';
import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';

class FichaPericias extends StatefulWidget {
  final Ficha ficha;
  const FichaPericias({Key? key, required this.ficha}) : super(key: key);

  @override
  State<FichaPericias> createState() => _FichaPericiasState();
}

class _FichaPericiasState extends State<FichaPericias> {
  @override
  Widget build(BuildContext context) {
    final ficha = ModalRoute.of(context)!.settings.arguments as Ficha;
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Pericias')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
      body: SingleChildScrollView(
          child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 381,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Treinada',
                      style: TextStyle(
                          fontSize: 24, color: SetColors.primaryRedColor),
                    ),
                    Text('Pericia',
                        style: TextStyle(
                            fontSize: 24, color: SetColors.primaryRedColor)),
                    Text('Total',
                        style: TextStyle(
                            fontSize: 24, color: SetColors.primaryRedColor)),
                    Text('Temp',
                        style: TextStyle(
                            fontSize: 24, color: SetColors.primaryRedColor)),
                    Text('Outro',
                        style: TextStyle(
                            fontSize: 24, color: SetColors.primaryRedColor))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: ficha.pericias.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CheckBoxPericia(
                                idPericia: ficha.pericias[index].idPericia,
                                idFicha: ficha.id,
                                tabela: 'pericias_ficha',
                                treinado: ficha.pericias[index].treinado,
                                onChanged: (newBool) {
                                  setState(() {
                                    ficha.pericias[index].treinado = newBool!;
                                    if (newBool == true) {
                                      final a = 1;
                                      updatePericias(
                                          'treinado',
                                          'pericias_ficha',
                                          a,
                                          ficha.id,
                                          ficha.pericias[index].idPericia);
                                    } else {
                                      final a = 0;
                                      updatePericias(
                                          'treinado',
                                          'pericias_ficha',
                                          a,
                                          ficha.id,
                                          ficha.pericias[index].idPericia);
                                    }
                                    ficha.calcularTotalPericia(index);
                                  });
                                },
                                coluna: 'treinado'),
                            RectangleBox(
                              width: 139,
                              nomeColuna: '',
                              id: ficha.pericias[index].idPericia,
                              initialValue: ficha.pericias[index].nomePericia,
                              tableName: '',
                              hintText: '',
                              enabled: false,
                            ),
                            SquareBox(
                              nomeColuna: '',
                              id: 0,
                              initialValue: ficha.pericias[index].total,
                              tableName: '',
                              enabled: false,
                            ),
                            SquareBoxPericia(
                              nomeColuna: 'mod_temp_pericia',
                              idFicha: ficha.id,
                              idPericia: ficha.pericias[index].idPericia,
                              initialValue:
                                  ficha.pericias[index].modTempPericia,
                              tableName: 'pericias_ficha',
                              onChanged: (value) {
                                ficha.pericias[index].setModTempPericia(value);
                                ficha.calcularTotalPericia(index);
                                setState(() {});
                              },
                            ),
                            SquareBoxPericia(
                              nomeColuna: 'mod_outros_pericia',
                              idFicha: ficha.id,
                              idPericia: ficha.pericias[index].idPericia,
                              initialValue:
                                  ficha.pericias[index].modOutrosPericia,
                              tableName: 'pericias_ficha',
                              onChanged: (value) {
                                ficha.pericias[index]
                                    .setModOutrosPericia(value);
                                ficha.calcularTotalPericia(index);
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
