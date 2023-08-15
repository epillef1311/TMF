import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FichaMagias extends StatefulWidget {
  const FichaMagias({super.key});

  @override
  State<FichaMagias> createState() => _FichaMagiasState();
}

class _FichaMagiasState extends State<FichaMagias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Magias')],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
    );
  }
}
