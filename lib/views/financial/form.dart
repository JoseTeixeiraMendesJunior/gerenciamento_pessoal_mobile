import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/financial_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/transactions_model.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class TransactionForm extends StatefulWidget {
  TransactionForm({
    required this.typeRequest,
      this.trasaction,
      super.key
    });

    TransactionModel? trasaction;
    final String typeRequest;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final FinancialController financialController = GetIt.I.get<FinancialController>();
  DateTime? _selectedTime;
  int? groupValue;

  @override
  void initState() {
    _selectedTime = null;
    financialController.disposeTransaction();
    if(widget.trasaction != null) {
      financialController.withTransaction(widget.trasaction!);
      groupValue = widget.trasaction?.type == 'income' ? 0 : 1;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: GlobalColors.navy,
        title: const Text('Nova Transação', style: TextStyle(color: Colors.white),),
      ),
      body: Observer(
        builder: (_) {
          return Column(
            // mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, right: 32, left: 32),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Valor'),
                    controller: financialController.amount,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32, left: 32),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Categoria'),
                    controller: financialController.category,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32, left: 32),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Descricao'),
                    controller: financialController.description,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32, left: 32),
                  child: GestureDetector(
                    onTap: () async {
                      _selectedTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2022),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                        currentDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child) =>
                            Theme(
                          data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: GlobalColors.navy)),
                          child: child!,
                        ),
                      );

                      if (_selectedTime != null) {
                        setState(() {
                          financialController.date.text =
                              '${_selectedTime!.year}-${_selectedTime!.month}-${_selectedTime!.day}';
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: financialController.date,
                        decoration: InputDecoration(
                            hintText: 'Dia da transação',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: GlobalColors.navy,
                                    width: 3))),
                      ),
                    ),
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                          child: Text(
                            'Tipo de transacao',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                        CupertinoSlidingSegmentedControl<int>(
                          thumbColor: GlobalColors.navy,
                          padding: const EdgeInsets.all(4),
                          groupValue: groupValue,
                          children: {
                            0: escalaItem('Receita', groupValue == 0? Colors.white : Colors.black),
                            1: escalaItem('Despesa', groupValue == 1? Colors.white : Colors.black),
                          },
                          onValueChanged: (value) => setState(() {
                            groupValue = value;
                            financialController.type.text
                             = value == 0 ? 'income' : 'expense';
                          }),
                        ),
                      ],
                    ),
                  ),
               
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool res =  widget.typeRequest ==  'create' ?
                        await financialController.createTransaction() :
                        await financialController.updateTransaction(widget.trasaction!.id!);

                        if(res == true && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Salvar'),
                  )
                ),
          ],
        );
      })
    );
  }

Widget escalaItem(String text, Color color) => Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: color),
      ),
    );

}

