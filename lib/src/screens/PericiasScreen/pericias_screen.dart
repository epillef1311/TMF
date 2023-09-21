import 'package:app/app/widgets/fichaWidget/Text_field.dart';
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
                            SquareBox(
                              nomeColuna: '',
                              id: ficha.pericias[index].idPericia,
                              initialValue: 0,
                              tableName: '',
                              enabled: false,
                            ),
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
                              initialValue: 0,
                              tableName: '',
                              enabled: false,
                            ),
                            SquareBox(
                                nomeColuna: 'mod_temp_pericia',
                                id: ficha.pericias[index].idPericia,
                                initialValue:
                                    ficha.pericias[index].modOutrosPericia,
                                tableName: '')
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
