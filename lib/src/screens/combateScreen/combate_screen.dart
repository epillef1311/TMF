import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';

class FichaCombate extends StatefulWidget {
  const FichaCombate({super.key});

  @override
  State<FichaCombate> createState() => _FichaCombateState();
}

class _FichaCombateState extends State<FichaCombate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Combate')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
    );
  }
}
