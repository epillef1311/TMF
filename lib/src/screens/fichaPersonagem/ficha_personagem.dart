import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';

class FichaPersonagem extends StatefulWidget {
  const FichaPersonagem({super.key});

  @override
  State<FichaPersonagem> createState() => _FichaPersonagemState();
}

class _FichaPersonagemState extends State<FichaPersonagem> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
