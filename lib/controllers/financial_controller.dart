import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/models/transactions_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/wallet.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../repositories/global_api.dart';
part 'financial_controller.g.dart';

class FinancialController = _FinancialControllerBase with _$FinancialController;

abstract class _FinancialControllerBase with Store {
  
  final GlobalApi rep = GetIt.I.get<GlobalApi>();

  /// TextControllers Transactions
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController category = TextEditingController();
 
  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  ObservableList<TransactionModel> transactions = ObservableList<TransactionModel>();

  @observable
  WalletModel wallet = WalletModel();

  @action
  getTransactions() async {
    changeLoading(true);
    List<TransactionModel> temp = await rep.getTransactions();
    transactions = temp.asObservable();

    WalletModel walletTemp = await rep.getWallet();
    wallet = walletTemp;

    changeLoading(false);
  }

  @action
  removeTransaction(int id) async {
    changeLoading(true);
    bool res = await rep.deleteTransactions(id);

    if(res == true) {
      WalletModel temp = wallet;

      int index = transactions.indexOf((element) => element.id == id);

      if(transactions[index].type == 'income') {
        temp.income = temp.income! - transactions[index].amount!;
      } else {
        temp.expense = temp.expense! - transactions[index].amount!;
      }

      temp.total = temp.income! + temp.expense!;
      wallet = temp;

      transactions.removeWhere((element) => element.id == id);
    } 
    changeLoading(false);
  }

  @action
  createTransaction() async {
    changeLoading(true);
    TransactionModel data = TransactionModel(
      amount: double.parse(amount.text),
      description: description.text,
      type: type.text,
      category: category.text,
      date: date.text,
    );

    TransactionModel res = await rep.createTransactions(data);

    if(res.id != null) {
      transactions.insert(0, res);
    }

    changeLoading(false);

    return res.id != null;
  }

}