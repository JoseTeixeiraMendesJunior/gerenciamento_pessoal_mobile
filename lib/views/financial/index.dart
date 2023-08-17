import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/financial_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/transactions_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/wallet.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:gerenciamento_pessoal_mobile/resources/widgets/globals.dart';
import 'package:gerenciamento_pessoal_mobile/views/financial/form.dart';
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
        // backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 5,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Gerenciamento Financeiro', style: TextStyle(color: Colors.white),),
            ],
          ),
          backgroundColor: GlobalColors.navy,
        ),
        body: financialController.isLoading ?
            const Center(child: LoadingWidget()) :
            financialController.transactions.isEmpty ? 
              const Center(child: EmptyWidget()) :
              FinancialBody(
                transactions: financialController.transactions,
                wallet: financialController.wallet,
                financialController: financialController,
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => TransactionForm(typeRequest: 'create',))),
          backgroundColor: GlobalColors.navy,
          elevation: 2,
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
        Stack(
          children: [
            const SizedBox(height: 200, child: HorizontalBackgraoundImage()),
            SizedBox(
              height: 200,
              child: GlassEfect(
                width: 1,
                bodyWidget: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 200,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text.rich(
                          TextSpan(
                            text: 'Montante: ',
                            style: const TextStyle(color: Colors.white, fontSize: 28),
                            children: [
                              TextSpan(
                                text: 'R\$ ${wallet.total}',
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
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                              children: [
                                TextSpan(
                                  text: 'R\$ ${wallet.income}',
                                )
                              ]
                            )
                          ),
                        Text.rich(
                            TextSpan(
                              text: 'Despesas: ',
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                              children: [
                                TextSpan(
                                  text: 'R\$ ${wallet.expense}',
                                )
                              ]
                            )
                          ),
                        ],
                      )
              
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) => TransactionElement(
              transation: transactions[index],
              financialController: financialController,
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionElement extends StatelessWidget {
  const TransactionElement({
        required this.transation,
        required this.financialController,
        super.key
      });

  final TransactionModel transation;
  final FinancialController financialController;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
              TransactionForm(trasaction: transation, typeRequest: 'update',),));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: transation.type == 'income' ? GlobalColors.olive : GlobalColors.red,
                 width: 3
                ),
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: const [0.001, 0.999],
                colors: [
                  transation.type == 'income' ? GlobalColors.olive : GlobalColors.red,
                  Colors.white,
                ]
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon( 
                  Icons.attach_money_rounded, 
                  color: Colors.white ,
                ),
                Column(
                  children: [
                    Text(
                      transation.type == 'income' ? 'Receita' : 'Despesa',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'R\$ ',
                        children: [
                          TextSpan(
                            text: transation.amount.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          )
                        ] 
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await financialController.removeTransaction(transation.id!);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red,))
              ],
            )
          ),
        ),
      );
  }
}