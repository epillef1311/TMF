import 'package:flutter/material.dart';
import 'package:app/app/themes/colors.dart';
import 'package:app/app/widgets/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: SetColors.primaryRedColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Home')],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 45,
                child: PrimaryButton(
                  title: 'Fichas',
                  onPressed: () {
                    Navigator.of(context).pushNamed('listaFichas');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 45,
                child: PrimaryButton(
                  onPressed: () {
                    // Ação para a opção "Perfil"
                  },
                  title: 'Perfil',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 45,
                child: PrimaryButton(
                  title: 'Compendium',
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 45,
                child: PrimaryButton(
                  title: 'Logout',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
