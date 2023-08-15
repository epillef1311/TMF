import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';

class FichaInventario extends StatefulWidget {
  const FichaInventario({super.key});

  @override
  State<FichaInventario> createState() => _FichaInventarioState();
}

class _FichaInventarioState extends State<FichaInventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Inventário')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
    );
  }
}
