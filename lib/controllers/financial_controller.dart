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

}