import 'package:flutter/material.dart';
import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/alert_dialog.dart';
import 'package:app/database/db.dart';
import 'package:app/app/widgets/button.dart';
import 'package:app/database/models/ficha.dart';

class ListaFichas extends StatefulWidget {
  const ListaFichas({Key? key}) : super(key: key);

  @override
  State<ListaFichas> createState() => _ListaFichasState();
}

class _ListaFichasState extends State<ListaFichas> {
  List<Ficha> fichas = [];

  reloadScreen() async {
    final data = await DB.instance.getAllNomes();
    setState(() {
      fichas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AlertDialogFicha(
        onDialogClosed: reloadScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Lista de fichas'),
          ],
        ),
        backgroundColor: SetColors.primaryRedColor,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Ficha>>(
        future: DB.instance.getAllNomes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final fichas = snapshot.data!;
            return ListView.builder(
              itemCount: fichas.length,
              itemBuilder: (context, index) {
                final ficha = fichas[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SizedBox(
                    height: 45,
                    child: FichaCardButton(
                      title: ficha.nome,
                      id: ficha.id,
                      deleteFunc: () {
                        DB.instance.deletarFicha(ficha.id, ficha.id);
                        reloadScreen();
                      },
                      onPressed: () {},
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Erro');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
