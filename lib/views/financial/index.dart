import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/financial_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/transactions_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/wallet.dart';
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
  void initState() {
    financialController.getTransactions();
    super.initState();
  }

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
              Text('Gerenciamento Financeiro'),
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
              else ...[FinancialBody(
                transactions: financialController.transactions,
                wallet: financialController.wallet,
                financialController: financialController,
                )],
      
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => HomeScreen())), // MUDAR
          backgroundColor: Colors.purple,
          elevation: 5,
          child: const Icon(Icons.add, color: Colors.white,),
          ),
      );
    });
  }
}

class FinancialBody extends StatelessWidget {
  const FinancialBody({
      required this.financialController,
      required this.transactions,
      required this.wallet,
      super.key
    });

    final FinancialController financialController;
    final List<TransactionModel> transactions;
    final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: Colors.purple[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text.rich(
                  TextSpan(
                    text: 'Total: ',
                    children: [
                      TextSpan(
                        text: wallet.total.toString(),
                      )
                    ]
                    
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Receitas: ',
                      children: [
                        TextSpan(
                          text: wallet.income.toString(),
                        )
                      ]
                    )
                  ),
                Text.rich(
                    TextSpan(
                      text: 'Despesas: ',
                      children: [
                        TextSpan(
                          text: wallet.expense.toString(),
                        )
                      ]
                    )
                  ),
                ],
              )

            ],
          ),
        ),
        Expanded(child: Container(color: Colors.amber,))
      ],
    );
  }
}