import 'package:app/app/themes/colors.dart';
import 'package:app/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CheckBoxPericia extends StatefulWidget {
  bool treinado;
  final String tabela;
  final int idPericia;
  final int idFicha;
  bool? isTrained = false;
  final String coluna;
  final Function(bool?) onChanged;

  CheckBoxPericia(
      {required this.idPericia,
      required this.idFicha,
      required this.tabela,
      required this.treinado,
      required this.onChanged,
      required this.coluna,
      super.key});

  @override
  State<CheckBoxPericia> createState() => _CheckBoxPericiaState();
}

class _CheckBoxPericiaState extends State<CheckBoxPericia> {
  @override
  void initState() {
    super.initState();
    if (widget.treinado == 1) {
      widget.isTrained = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: SetColors.primaryRedColor),
        color: SetColors.backGroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Checkbox(
        value: widget.treinado,
        onChanged: widget.onChanged,
      ),
    );
  }
}
