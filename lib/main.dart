import 'package:app/app/widgets/botton_nav_bar.dart';
import 'package:app/src/screens/fichaPersonagem/ficha_personagem.dart';
import 'package:app/src/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'database/db.dart';
import 'src/screens/auth/login_screen.dart';
import 'src/screens/lista_fichas/lista_fichas_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.database;
  runApp(const TormentaFichaApp());
}

class TormentaFichaApp extends StatelessWidget {
  const TormentaFichaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        'listaFichas': (context) => const ListaFichas(),
        'bottonNavBar': (context) => const BottonNavBar()
      },
    );
  }
}
