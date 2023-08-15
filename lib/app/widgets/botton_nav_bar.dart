import 'package:app/app/themes/colors.dart';
import 'package:app/src/screens/PericiasScreen/pericias_screen.dart';
import 'package:app/src/screens/combateScreen/combate_screen.dart';
import 'package:app/src/screens/fichaPersonagem/ficha_personagem.dart';
import 'package:app/src/screens/inventarioScreen/inventario_screen.dart';
import 'package:app/src/screens/magiasScreen/magias_screen.dart';
import 'package:app/src/screens/talentosHabilidades/talentos_habilidades_screen.dart';
import 'package:flutter/material.dart';

class BottonNavBar extends StatefulWidget {
  const BottonNavBar({super.key});

  @override
  State<BottonNavBar> createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar> {
  int screenAtual = 0;
  late PageController pc;
  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: screenAtual);
  }

  setScreenAtual(screen) {
    setState(() {
      screenAtual = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setScreenAtual,
        children: const [
          FichaPersonagem(),
          FichaPericias(),
          FichaHabilidadesTalentos(),
          FichaCombate(),
          FichaMagias(),
          FichaInventario()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black))),
        child: BottomNavigationBar(
          currentIndex: screenAtual,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.house),
                label: 'Status',
                backgroundColor: SetColors.primaryRedColor),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Pericias'),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc_sharp), label: 'Habilidades'),
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen), label: 'Combate'),
            BottomNavigationBarItem(
                icon: Icon(Icons.fire_extinguisher), label: 'Magias'),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Inventário',
            )
          ],
          onTap: (screen) {
            pc.animateToPage(screen,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          },
        ),
      ),
    );
  }
}
