// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MainDivider extends StatefulWidget {
  const MainDivider({super.key});

  @override
  State<MainDivider> createState() => _MainDividerState();
}

class _MainDividerState extends State<MainDivider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 3,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFA63333), Colors.transparent],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [Text('Ou')],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 3,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFA63333), Colors.transparent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
            ),
          ),
        ),
      ],
    );
  }
}
