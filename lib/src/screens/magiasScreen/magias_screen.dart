import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/button.dart';
import 'package:app/database/db.dart';
import 'package:app/database/models/ficha.dart';
import 'package:app/database/models/magia.dart';
import 'package:app/src/screens/magiasScreen/magia_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FichaMagias extends StatefulWidget {
  Ficha ficha;
  List<Magia> truques = [];
  List<Magia> magias1 = [];
  List<Magia> magias2 = [];
  List<Magia> magias3 = [];
  List<Magia> magias4 = [];
  List<Magia> magias5 = [];
  List<Magia> magias6 = [];
  List<Magia> magias7 = [];
  List<Magia> magias8 = [];
  List<Magia> magias9 = [];
  FichaMagias({super.key, required this.ficha});

  @override
  State<FichaMagias> createState() => _FichaMagiasState();
}

class _FichaMagiasState extends State<FichaMagias> {
  @override
  void initState() {
    setState(() {
      separarMagiasPorNivel(widget.ficha.magias);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ficha = ModalRoute.of(context)!.settings.arguments as Ficha;

    return Scaffold(
        backgroundColor: SetColors.backGroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Magias')],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: SetColors.primaryRedColor,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: MagiaTile(
                magias: widget.truques,
                nivel: "truques",
                id: widget.ficha.id,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias1, nivel: "1", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias2, nivel: "2", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias3, nivel: "3", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias4, nivel: "4", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias5, nivel: "5", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias6, nivel: "6", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias7, nivel: "7", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias8, nivel: "8", id: widget.ficha.id)),
            Padding(
                padding: EdgeInsets.all(5),
                child: MagiaTile(
                    magias: widget.magias9, nivel: "9", id: widget.ficha.id))
          ],
        ));
  }

  void separarMagiasPorNivel(List<Magia> magias) {
    /*widget.truques = [];
    widget.magias1 = [];
    widget.magias2 = [];
    widget.magias3 = [];
    widget.magias4 = [];
    widget.magias5 = [];
    widget.magias6 = [];
    widget.magias7 = [];
    widget.magias8 = [];
    widget.magias9 = [];*/
    for (Magia magia in magias) {
      switch (magia.nivel) {
        case "truques":
          widget.truques.add(magia);
          break;
        case "1":
          widget.magias1.add(magia);
          break;
        case "2":
          widget.magias1.add(magia);
          break;
        case "3":
          widget.magias1.add(magia);
          break;
        case "4":
          widget.magias1.add(magia);
          break;
        case "5":
          widget.magias1.add(magia);
          break;
        case "6":
          widget.magias1.add(magia);
          break;
        case "7":
          widget.magias1.add(magia);
          break;
        case "8":
          widget.magias1.add(magia);
          break;
        case "9":
          widget.magias1.add(magia);
          break;
      }
    }
  }
}

class MagiaTile extends StatefulWidget {
  String nivel;
  int id;
  MagiaTile({
    super.key,
    required this.magias,
    required this.nivel,
    required this.id,
  });

  final List<Magia> magias;

  @override
  State<MagiaTile> createState() => _MagiaTileState();
}

class _MagiaTileState extends State<MagiaTile> {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      tileColor: SetColors.primaryRedColor,
      child: ExpansionTile(
        title: Text(
          widget.nivel,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
        childrenPadding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.magias.length,
            itemBuilder: (BuildContext context, int index) {
              //return Text(magias[index].nomeMagia);
              return Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 45,
                  child: FichaCardButton(
                      id: widget.id,
                      title: widget.magias[index].nomeMagia,
                      deleteFunc: () {
                        setState(() {
                          deleteMagia(widget.magias[index].id, widget.id);
                          widget.magias.remove(widget.magias[index]);
                        });
                      },
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => MagiaScreen(
                                      magia: widget.magias[index],
                                    )))
                            .then((_) {
                          setState(() {
                            widget.magias[index]
                                .loadMagia(widget.id, widget.magias[index].id);
                          });
                        });
                      }),
                ),
              );
            },
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: FloatingActionButton(
                heroTag: UniqueKey(),
                onPressed: () async {
                  int idMagia = await createNewMagia(widget.id, widget.nivel);
                  Magia magia = Magia(id: idMagia);
                  magia.nomeMagia = 'Nova Magia';
                  widget.magias.add(magia);
                  setState(() {});
                },
                backgroundColor: SetColors.primaryRedColor,
                mini: true,
                child: const Icon(Icons.add),
              ))
        ],
      ),
    );
  }
}
