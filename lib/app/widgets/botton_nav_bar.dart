import 'package:app/app/themes/colors.dart';
import 'package:app/src/screens/auth/login_screen.dart';
import 'package:app/src/screens/fichaPersonagem/ficha_personagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        children: const [FichaPersonagem(), LoginScreen()],
        onPageChanged: setScreenAtual,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black))),
        child: BottomNavigationBar(
          currentIndex: screenAtual,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: 'perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'login')
          ],
          onTap: (screen) {
            pc.animateToPage(screen,
                duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
          backgroundColor: SetColors.primaryRedColor,
        ),
      ),
    );
  }
}
