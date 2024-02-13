import 'package:app/app/themes/colors.dart';
import 'package:flutter/material.dart';

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
    return Transform.scale(
        scale: 1.8,
        child: Checkbox(
            value: widget.treinado,
            onChanged: widget.onChanged,
            side: const BorderSide(color: SetColors.primaryRedColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            )));
  }
}
