import 'package:flutter/material.dart';
import 'package:app/app/themes/colors.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Color color;
  final Color textColor;
  final Function() onPressed;
  final BorderRadius? borderRadius;
  const PrimaryButton(
      {Key? key,
      required this.title,
      this.color = SetColors.primaryRedColor,
      this.textColor = Colors.white,
      required this.onPressed,
      this.borderRadius})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  late final BorderRadius borderRadius;
  @override
  void initState() {
    super.initState();
    borderRadius = widget.borderRadius ?? BorderRadius.circular(8);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
          minimumSize: const Size.fromWidth(330),
          fixedSize: const Size(330, 60),
          padding: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: widget.color),
      child: Text(
        widget.title,
        style: TextStyle(
            color: widget.textColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
