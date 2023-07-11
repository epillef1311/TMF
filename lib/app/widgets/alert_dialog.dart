import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:app/database/db.dart';
import 'package:app/app/themes/colors.dart';

class AlertDialogFicha extends StatefulWidget {
  const AlertDialogFicha({super.key});

  @override
  State<AlertDialogFicha> createState() => _AlertDialogFichaState();
}

class _AlertDialogFichaState extends State<AlertDialogFicha> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: SetColors.primaryRedColor,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              var nomeControler = TextEditingController();
              return AlertDialog(
                title: Text('Qual o nome do personagem?'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(hintText: 'Nome'),
                        controller: nomeControler,
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        DB.instance.inserirNome(nomeControler.text);
                        Navigator.of(context).pop();
                      },
                      child: Text('pronto')),
                ],
              );
            });
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
