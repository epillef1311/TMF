import 'package:flutter/material.dart';
import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/alert_dialog.dart';
import 'package:app/database/db.dart';
import 'package:app/app/widgets/button.dart';

class ListaFichas extends StatefulWidget {
  const ListaFichas({Key? key}) : super(key: key);

  @override
  State<ListaFichas> createState() => _ListaFichasState();
}

class _ListaFichasState extends State<ListaFichas> {
  Future<List<String>> _getNomes() async {
    final database = await DB.instance.database;
    final List<Map<String, dynamic>> nomeList = await database.query('fichas');
    return nomeList.map((nome) => nome['nomePersonagem'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AlertDialogFicha(),
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
      body: FutureBuilder<List<String>>(
        future: _getNomes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final nomes = snapshot.data!;
            return ListView.builder(
              itemCount: nomes.length,
              itemBuilder: (context, index) {
                final nome = nomes[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SizedBox(
                    height: 45,
                    child: PrimaryButton(
                      title: nome,
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
