import 'package:app/database/models/ficha.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
    //ficha.loadFicha(ficha.id);
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Pericias')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
    );
  }
}
