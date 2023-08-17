import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/financial_controller.dart';
import 'package:gerenciamento_pessoal_mobile/views/home/index.dart';
import 'package:get_it/get_it.dart';

import '../../resources/widgets/comuns.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  
  final FinancialController financialController = GetIt.I.get<FinancialController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Lista de Compras'),
            ],
          ),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          children: [
              if(financialController.isLoading)
                ...[const Center(child: LoadingWidget())]
              else if(financialController.transactions.isEmpty) 
                ...[const Center(child: EmptyWidget())]
              // else ...[ShoppingListBody(
              //   shoppingList: shoppingController.shoppingList,
              //   shoppingController: shoppingController,
              //   )],
      
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => HomeScreen())),
          backgroundColor: Colors.purple,
          elevation: 5,
          child: const Icon(Icons.add, color: Colors.white,),
          ),
      );
    });
  }
}