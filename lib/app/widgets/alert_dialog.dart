import 'package:app/database/models/bonus_pericia.dart';
import 'package:app/database/models/pericia.dart';
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
//-------------------------------------------------------------------------------

class AlertDialogPericia extends StatefulWidget {
  final Function()? onDialogClosed;
  final int idPericiaFicha;
  Pericia pericia;

  AlertDialogPericia(
      {Key? key,
      this.onDialogClosed,
      required this.idPericiaFicha,
      required this.pericia})
      : super(key: key);

  @override
  State<AlertDialogPericia> createState() => _AlertDialogPericiaState();
}

class _AlertDialogPericiaState extends State<AlertDialogPericia> {
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
              title: const Text('Origem:'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(hintText: 'Origem'),
                      controller: nomeController,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final database = await DB.instance.database;
                    int idInserido = -1;
                    await database.transaction((txn) async {
                      idInserido = await txn.insert(
                        'pericias_outros',
                        {
                          'origem': nomeController.text,
                          "id_pericia_ficha": widget.idPericiaFicha
                        },
                      );
                    });
                    BonusPericia novoBonus = BonusPericia(
                        idBonus: idInserido,
                        idPericiaFicha: widget.idPericiaFicha);
                    novoBonus.setBonus(0);
                    novoBonus.setOrigem(nomeController.text);
                    widget.pericia.modOutrosPericia.add(novoBonus);
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
