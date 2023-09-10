import 'package:app/app/themes/colors.dart';
import 'package:app/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SquareBox extends StatefulWidget {
  late TextEditingController squareControler;
  SquareBox({Key? key}) : super(key: key) {
    squareControler =
        TextEditingController(); // Inicializa o controlador no construtor.
  }

  @override
  State<SquareBox> createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
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
          ]),
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        controller: widget.squareControler,
      ),
    );
  }
}

//------------------------------------------------------------------------------

class RectangleBox extends StatefulWidget {
  late TextEditingController rectangleController;
  final double width;
  final String nomeColuna;
  final int id;
  String? initialValue;
  final String tableName;
  final String hintText;

  RectangleBox(
      {required this.width,
      required this.nomeColuna,
      required this.id,
      required this.initialValue,
      required this.tableName,
      required this.hintText,
      Key? key})
      : super(key: key) {
    rectangleController = TextEditingController();
  }

  @override
  State<RectangleBox> createState() => _RectangleBoxState();
}

class _RectangleBoxState extends State<RectangleBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.rectangleController;
    if (widget.initialValue == null) {
      _controller.text = '';
    } else {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: SetColors.primaryRedColor),
          color: SetColors.backGroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 2),
            )
          ]),
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        controller: _controller,
        onSubmitted: (value) {
          updateFicha(widget.tableName, widget.nomeColuna, value, widget.id);
        },
        decoration: InputDecoration(hintText: widget.hintText),
      ),
    );
  }
}
