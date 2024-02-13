import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/fichaWidget/Text_field.dart';
import 'package:app/database/models/magia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MagiaScreen extends StatefulWidget {
  Magia magia;
  MagiaScreen({super.key, required this.magia});

  @override
  State<MagiaScreen> createState() => _MagiaScreenState();
}

class _MagiaScreenState extends State<MagiaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.magia.nomeMagia)],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: SetColors.primaryRedColor,
      ),
      body: ListView(padding: EdgeInsets.only(top: 5), children: [
        MagiaTileDetalhe(
          textoPrev: 'Nome:',
          nomeColuna: 'nome_magia',
          magiaId: widget.magia.id,
          initialValue: widget.magia.nomeMagia,
          hintText: 'Nome',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Alvo/Área:',
          nomeColuna: 'alvo_area',
          magiaId: widget.magia.id,
          initialValue: widget.magia.alvoArea,
          hintText: 'alvo/área',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Tempo.Exec:',
          nomeColuna: 'tempo_execucao',
          magiaId: widget.magia.id,
          initialValue: widget.magia.tempoExec,
          hintText: 'tempo execução',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Escola:',
          nomeColuna: 'escola',
          magiaId: widget.magia.id,
          initialValue: widget.magia.escola,
          hintText: 'Escola',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Duração:',
          nomeColuna: 'duracao',
          magiaId: widget.magia.id,
          initialValue: widget.magia.duracao,
          hintText: 'Duração',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Alcance:',
          nomeColuna: 'alcance',
          magiaId: widget.magia.id,
          initialValue: widget.magia.alcance,
          hintText: 'alcance',
        ),
        MagiaTileDetalhe(
          textoPrev: 'Teste de Resistência:',
          nomeColuna: 'teste_resistencia',
          magiaId: widget.magia.id,
          initialValue: widget.magia.testeResistencia,
          hintText: 'Teste de Resistência',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RectangleBox(
            width: 139,
            nomeColuna: 'nomeColuna',
            id: 1,
            initialValue: 'Descrição:',
            tableName: 'tableName',
            hintText: 'Descrição:',
            enableBorder: false,
            enabled: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5.0),
          child: Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RectangleBox(
                width: 200,
                height: 300,
                nomeColuna: 'descricao',
                id: widget.magia.id,
                initialValue: widget.magia.descricao,
                tableName: 'magias',
                hintText: 'descrição',
                maxLines: 50,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class MagiaTileDetalhe extends StatefulWidget {
  final String textoPrev;
  final String nomeColuna;
  final int magiaId;
  final String? initialValue;
  final String hintText;
  MagiaTileDetalhe(
      {super.key,
      required this.magiaId,
      required this.initialValue,
      required this.hintText,
      required this.textoPrev,
      required this.nomeColuna});

  @override
  State<MagiaTileDetalhe> createState() => _MagiaTileDetalheState();
}

class _MagiaTileDetalheState extends State<MagiaTileDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RectangleBox(
            width: 139,
            nomeColuna: '',
            id: 1,
            initialValue: widget.textoPrev,
            tableName: '',
            hintText: 'hintText',
            enabled: false,
            enableBorder: false,
          ),
          RectangleBox(
            width: 139,
            nomeColuna: widget.nomeColuna,
            id: widget.magiaId,
            initialValue: widget.initialValue,
            tableName: 'magias',
            hintText: widget.hintText,
          )
        ],
      ),
    );
  }
}
