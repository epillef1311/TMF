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
  bool enableBorder;
  Border border = Border.all(width: 2, color: SetColors.primaryRedColor);
  Color shadow = Colors.black;
  bool enabled;

  SquareBox({
    required this.nomeColuna,
    required this.id,
    required this.initialValue,
    required this.tableName,
    this.onChanged,
    this.enabled = true,
    this.enableBorder = true,
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
    if (widget.enableBorder == false) {
      widget.border = Border.all(color: Colors.transparent);
      widget.shadow = Colors.transparent;
    }
    if (widget.enabled == true) {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
          color: SetColors.backGroundColor,
          boxShadow: [
            BoxShadow(
              color: widget.shadow,
              blurRadius: 1,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 20),
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
          border: widget.border,
          color: SetColors.backGroundColor,
          boxShadow: [
            BoxShadow(
              color: widget.shadow,
              blurRadius: 1,
              offset: const Offset(0, 1),
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
  bool enableBorder;
  Border border = Border.all(width: 2, color: SetColors.primaryRedColor);
  Color shadow = Colors.black;
  double? height = 50;
  int maxLines = 1;

  RectangleBox(
      {required this.width,
      required this.nomeColuna,
      required this.id,
      required this.initialValue,
      required this.tableName,
      required this.hintText,
      this.onChanged,
      this.enabled = true,
      this.enableBorder = true,
      this.height = 50,
      this.maxLines = 1,
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
    if (widget.enableBorder == false) {
      widget.border = Border.all(color: Colors.transparent);
      widget.shadow = Colors.transparent;
    }
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: widget.border,
          color: SetColors.backGroundColor,
          boxShadow: [
            BoxShadow(
              color: widget.shadow,
              blurRadius: 1,
              offset: const Offset(0, 2),
            )
          ]),
      child: TextField(
        maxLines: widget.maxLines,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
            hintText: widget.hintText, border: InputBorder.none),
        onChanged: widget.onChanged,
        enabled: widget.enabled,
      ),
    );
  }
}

class SquareBoxPericia extends StatefulWidget {
  late TextEditingController squareControler;
  final String nomeColuna;
  final int idFicha;
  final int idPericia;
  int? initialValue;
  final String tableName;
  final void Function(String)? onChanged;
  bool enableBorder;
  Border border = Border.all(width: 2, color: SetColors.primaryRedColor);
  bool enabled;
  final void Function()? onTap;

  SquareBoxPericia({
    required this.nomeColuna,
    required this.idFicha,
    required this.idPericia,
    required this.initialValue,
    required this.tableName,
    this.onChanged,
    this.enabled = true,
    this.enableBorder = true,
    this.onTap,
    Key? key,
  }) : super(key: key) {
    squareControler = TextEditingController();
  }

  @override
  State<SquareBoxPericia> createState() => _SquareBoxPericiaState();
}

class _SquareBoxPericiaState extends State<SquareBoxPericia> {
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
            updatePericias(widget.nomeColuna, widget.tableName, newValue,
                widget.idFicha, widget.idPericia);
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
    if (widget.enableBorder == false) {
      widget.border = Border.all(color: Colors.transparent);
    }
    if (widget.enabled == true) {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
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
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          onTap: widget.onTap,
        ),
      );
    } else {
      int? valor = widget.initialValue;
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
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

class SquareBoxPericiaOutro extends StatefulWidget {
  late TextEditingController squareControler;
  final String nomeColuna;
  final int idFicha;
  final int idPericia;
  int? initialValue;
  final String tableName;
  final void Function(String)? onChanged;
  bool enableBorder;
  Border border = Border.all(width: 2, color: SetColors.primaryRedColor);
  bool enabled;
  final void Function()? onTap;

  SquareBoxPericiaOutro({
    required this.nomeColuna,
    required this.idFicha,
    required this.idPericia,
    required this.initialValue,
    required this.tableName,
    this.onChanged,
    this.enabled = true,
    this.enableBorder = true,
    this.onTap,
    Key? key,
  }) : super(key: key) {
    squareControler = TextEditingController();
  }

  @override
  State<SquareBoxPericiaOutro> createState() => _SquareBoxPericiaOutroState();
}

class _SquareBoxPericiaOutroState extends State<SquareBoxPericiaOutro> {
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
            updateBonusPericia(
                widget.tableName, widget.nomeColuna, newValue, widget.idFicha);
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
    if (widget.enableBorder == false) {
      widget.border = Border.all(color: Colors.transparent);
    }
    if (widget.enabled == true) {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
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
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          onTap: widget.onTap,
        ),
      );
    } else {
      int? valor = widget.initialValue;
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
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
