// ignore_for_file: must_be_immutable
import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/alert_dialog.dart';
import 'package:app/app/widgets/fichaWidget/Text_field.dart';
import 'package:app/database/db.dart';
import 'package:app/database/models/ficha.dart';
import 'package:app/database/models/pericia.dart';
import 'package:flutter/material.dart';

class PericiaOutrosScreen extends StatefulWidget {
  Pericia pericia;
  int idFicha;
  int indexPericia;
  Ficha ficha;

  PericiaOutrosScreen(
      {super.key,
      required this.pericia,
      required this.idFicha,
      required this.indexPericia,
      required this.ficha});

  @override
  State<PericiaOutrosScreen> createState() => _PericiaOutrosScreenState();
}

class _PericiaOutrosScreenState extends State<PericiaOutrosScreen> {
  reloadScreen() async {
    setState(() {
      widget.pericia.loadPericia(widget.idFicha, widget.pericia.idPericia);
      widget.pericia.modOutrosPericia;
      widget.pericia.somarBonus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AlertDialogPericia(
          pericia: widget.pericia,
          onDialogClosed: reloadScreen,
          idPericiaFicha: widget.pericia.idPericiaFicha,
        ),
        backgroundColor: SetColors.backGroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.pericia.nomePericia)],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: SetColors.primaryRedColor,
        ),
        body: WillPopScope(
          onWillPop: () async {
            widget.ficha.calcularTotalPericia(widget.indexPericia);
            Navigator.of(context).pop();
            return true;
          },
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 381,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Bonus",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: SetColors.primaryRedColor),
                            ),
                            Text(
                              "Origem",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: SetColors.primaryRedColor),
                            ),
                            Text("              ")
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                        itemCount: widget.pericia.modOutrosPericia.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SquareBoxPericiaOutro(
                                    nomeColuna: "bonus",
                                    idPericia: widget.pericia
                                        .modOutrosPericia[index].idBonus,
                                    idFicha: widget.pericia
                                        .modOutrosPericia[index].idBonus,
                                    initialValue: widget.pericia
                                        .modOutrosPericia[index].getBonus,
                                    tableName: "pericias_outros",
                                    onChanged: (value) {
                                      int a = 0;
                                      if (value != "") {
                                        a = int.parse(value);
                                      }

                                      updateBonusPericia(
                                          "pericias_outros",
                                          "bonus",
                                          value,
                                          widget.pericia.modOutrosPericia[index]
                                              .idBonus);
                                      widget.pericia.modOutrosPericia[index]
                                          .setBonus(a);
                                      widget.pericia.somarBonus();
                                    },
                                  ),
                                  RectangleBox(
                                    hintText: "origem",
                                    width: 139,
                                    nomeColuna: "origem",
                                    id: widget.pericia.modOutrosPericia[index]
                                        .idBonus,
                                    initialValue: widget.pericia
                                        .modOutrosPericia[index].getOrigem,
                                    tableName: "pericias_outros",
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        deleteBonusPericia(widget.pericia
                                            .modOutrosPericia[index].idBonus);
                                        widget.pericia.modOutrosPericia.remove(
                                            widget.pericia
                                                .modOutrosPericia[index]);
                                      },
                                      icon: const Icon(Icons.delete))
                                ]),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
