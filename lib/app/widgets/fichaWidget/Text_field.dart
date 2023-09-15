import 'package:app/app/themes/colors.dart';
import 'package:app/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SquareBox extends StatefulWidget {
  late TextEditingController squareControler;
  final String nomeColuna;
  final int id;
  int? initialValue;
  final String tableName;
  final void Function(String)? onChanged;
  bool enabled;

  SquareBox({
    required this.nomeColuna,
    required this.id,
    required this.initialValue,
    required this.tableName,
    this.onChanged,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    squareControler = TextEditingController();
  }

  @override
  State<SquareBox> createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  late TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  redrawWidget() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.squareControler;
    _focusNode = FocusNode();
    if (widget.enabled == true) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          setState(() {
            int? newValue = int.tryParse(_controller.text);
            updateFicha(
                widget.tableName, widget.nomeColuna, newValue, widget.id);
          });
        }
      });
    }

    if (widget.initialValue == null) {
      _controller.text = '0';
    } else {
      int j = widget.initialValue!;
      String t = '$j';
      _controller.text = t;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled == true) {
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
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
        ),
      );
    } else {
      int? valor = widget.initialValue;
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
        alignment: Alignment.center,
        child: Text(
          '$valor',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}

//------------------------------------------------------------------------------

class RectangleBox extends StatefulWidget {
  final double width;
  final String nomeColuna;
  final int id;
  String? initialValue;
  final String tableName;
  final String hintText;
  final void Function(String)? onChanged;
  bool enabled;

  RectangleBox(
      {required this.width,
      required this.nomeColuna,
      required this.id,
      required this.initialValue,
      required this.tableName,
      required this.hintText,
      this.onChanged,
      this.enabled = true,
      Key? key})
      : super(key: key);

  @override
  State<RectangleBox> createState() => _RectangleBoxState();
}

class _RectangleBoxState extends State<RectangleBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.enabled == true) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          setState(() {
            updateFicha(widget.tableName, widget.nomeColuna, _controller.text,
                widget.id);
            widget.initialValue = _controller.text;
          });
        }
      });
    }

    if (widget.initialValue == null) {
      _controller.text = '';
    } else {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
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
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(hintText: widget.hintText),
        onChanged: widget.onChanged,
        enabled: widget.enabled,
      ),
    );
  }
}
