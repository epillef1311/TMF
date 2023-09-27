import 'package:flutter/material.dart';
import 'package:app/database/db.dart';
import 'package:app/app/themes/colors.dart';

class AlertDialogFicha extends StatefulWidget {
  final Function()? onDialogClosed;

  const AlertDialogFicha({Key? key, this.onDialogClosed}) : super(key: key);

  @override
  State<AlertDialogFicha> createState() => _AlertDialogFichaState();
}

class _AlertDialogFichaState extends State<AlertDialogFicha> {
  final nomeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: SetColors.primaryRedColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Qual o nome do personagem?'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(hintText: 'Nome'),
                      controller: nomeController,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    int id;
                    id = await DB.instance.inserirNome(nomeController.text);
                    createNewClass(id);
                    createNewHabilities(id);
                    createPericias(id);
                    createNewArmor(id);
                    Navigator.of(context).pop();
                    nomeController.text = '';
                  },
                  child: const Text('Pronto'),
                ),
              ],
            );
          },
        ).then((value) {
          // Executar ação quando o AlertDialog for fechado
          if (widget.onDialogClosed != null) {
            widget.onDialogClosed!();
          }
        });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
