import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FichaHabilidadesTalentos extends StatefulWidget {
  const FichaHabilidadesTalentos({super.key});

  @override
  State<FichaHabilidadesTalentos> createState() =>
      _FichaHabilidadesTalentosState();
}

class _FichaHabilidadesTalentosState extends State<FichaHabilidadesTalentos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Habilidades de classe e talentos')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
    );
  }
}
