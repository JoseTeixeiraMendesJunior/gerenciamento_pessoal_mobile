
import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/login_controller.dart';
import 'package:gerenciamento_pessoal_mobile/views/home/index.dart';
import 'package:gerenciamento_pessoal_mobile/views/login/register.dart';
import 'package:get_it/get_it.dart';

import '../../resources/global_colors.dart';
import '../../resources/global_dialogs.dart';
import '../../resources/global_scafold.dart';
import '../../resources/widgets/globals.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgraoundImage(),
          GlassEfect(bodyWidget: BodyLoginWidget())
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatelessWidget {
  BodyLoginWidget({
    Key? key,
  }) : super(key: key);

    final loginController = GetIt.I.get<LoginController>();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: LogoWidget(
            topPadding: 0,
          ),
        ),
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 64, bottom: 32, right: 32, left: 32),
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  controller: loginController.name,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  controller: loginController.password,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      
                      bool res = await loginController.login();

                      if(res == true && context.mounted) {
                        Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                      }
                    },
                    child: const Text('Entrar'),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            'Cadastrar-se',
                            style: TextStyle(color: GlobalColors.red),
                          )),
                      TextButton(
                          onPressed: () {
                            animatedDialogPadrao(
                                context, const RememberPassword());
                          },
                          child: const Text(
                            'Recuperar Senha',
                            style: TextStyle(color: GlobalColors.blue),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class RememberPassword extends StatelessWidget {
  const RememberPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Recuperção de Senha'),
      content: const TextField(
        decoration: InputDecoration(label: Text('Informe seu email')),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Fechar',
                  style: TextStyle(color: GlobalColors.red),
                )),
            TextButton(
                onPressed: () {
                  GlobalScaffold.instance.snackBarStatus(
                      'Nova senha enviada ao seu email',
                      );
                  Navigator.pop(context);
                },
                child: const Text('Enviar'))
          ],
        )
      ],
    );
  }
}