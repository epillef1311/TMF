import 'package:app/app/widgets/button.dart';
import 'package:app/app/widgets/dividers.dart';
import 'package:app/app/widgets/text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:app/app/themes/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: SetColors.backGroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/fichasDeRPG.jpg',
                    ),
                  )
                ],
              )),
              Container(
                height: 480,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 30,
                ),
                decoration:
                    const BoxDecoration(color: SetColors.backGroundColor),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 5),
                    child: Row(
                      children: const [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: SetColors.primaryRedColor, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  //email
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: OutlinedTextFormField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      isDense: true,
                      icon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  //senha
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: OutlinedTextFormField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      hintText: 'Senha',
                      isDense: true,
                      icon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  //esqueceu senha
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {},
                              child: const Text(
                                'Esqueceu a senha ?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ))
                        ]),
                  ),
                  //Login
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                        height: 45,
                        child: PrimaryButton(
                            title: 'Login',
                            onPressed: () {
                              Navigator.of(context).pushNamed('/home');
                            })),
                  ),
                  //Divisor
                  const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: MainDivider()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      height: 45,
                      child: PrimaryButton(
                        title: 'Criar conta',
                        onPressed: () {},
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
