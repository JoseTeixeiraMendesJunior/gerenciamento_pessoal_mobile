import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/login_controller.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:get_it/get_it.dart';

import '../../resources/global_scafold.dart';
import '../../resources/widgets/globals.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Stack(
                children: [
                  const BackgraoundImage(),
                  GlassEfect(bodyWidget: BodyRegisterWidget())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BodyRegisterWidget extends StatelessWidget {
  BodyRegisterWidget({Key? key}) : super(key: key);
  final loginController = GetIt.I.get<LoginController>();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          // height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Cadastro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 64, bottom: 32, right: 32, left: 32),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome'),
                  controller: loginController.registerName,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  controller: loginController.registerEmail,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  controller: loginController.registerPassword,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
              //   child: TextFormField(
              //     decoration:
              //         const InputDecoration(hintText: 'Confirmação de senha'),
              //   ),
              // ),
              Padding(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool res = await loginController.register();

                      if(res == true && context.mounted) {
                          GlobalScaffold.instance.snackBarStatus(
                          'Cadastro efetuado com sucesso',color: GlobalColors.olive);
                      Navigator.pop(context);
                      }
                      
                    },
                    child: const Text('Salvar'),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}