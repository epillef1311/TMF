import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/button.dart';
import 'package:app/app/widgets/fichaWidget/Text_field.dart';
import 'package:app/database/models/ficha.dart';
import 'package:flutter/material.dart';

class FichaPersonagem extends StatefulWidget {
  final Ficha ficha;

  const FichaPersonagem({Key? key, required this.ficha}) : super(key: key);

  @override
  State<FichaPersonagem> createState() => _FichaPersonagemState();
}

class _FichaPersonagemState extends State<FichaPersonagem> {
  @override
  Widget build(BuildContext context) {
    final ficha = ModalRoute.of(context)!.settings.arguments as Ficha;
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    // NOME PERSONAGEM
                    padding: EdgeInsets.all(5),
                    child: RectangleBox(
                        width: 234,
                        nomeColuna: 'nome_personagem',
                        id: ficha.id,
                        initialValue: ficha.nome,
                        tableName: 'fichas',
                        hintText: 'nome do personagem'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: RectangleBox(
                        width: 110,
                        nomeColuna: 'sexo',
                        id: ficha.id,
                        initialValue: ficha.sexo,
                        tableName: 'fichas',
                        hintText: 'sexo'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: RectangleBox(
                        width: 112,
                        nomeColuna: 'raca',
                        id: ficha.id,
                        initialValue: ficha.raca,
                        tableName: 'fichas',
                        hintText: 'raça'),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
