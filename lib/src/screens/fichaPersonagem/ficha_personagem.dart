import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/button.dart';
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
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(title: ficha.nome, onPressed: () {}),
      )),
    );
  }
}
