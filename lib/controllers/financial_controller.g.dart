// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FinancialController on _FinancialControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_FinancialControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$transactionsAtom =
      Atom(name: '_FinancialControllerBase.transactions', context: context);

  @override
  ObservableList<TransactionModel> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<TransactionModel> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$walletAtom =
      Atom(name: '_FinancialControllerBase.wallet', context: context);

  @override
  WalletModel get wallet {
    _$walletAtom.reportRead();
    return super.wallet;
  }

  @override
  set wallet(WalletModel value) {
    _$walletAtom.reportWrite(value, super.wallet, () {
      super.wallet = value;
    });
  }

  late final _$getTransactionsAsyncAction =
      AsyncAction('_FinancialControllerBase.getTransactions', context: context);

  @override
  Future getTransactions() {
    return _$getTransactionsAsyncAction.run(() => super.getTransactions());
  }

  late final _$removeTransactionAsyncAction = AsyncAction(
      '_FinancialControllerBase.removeTransaction',
      context: context);

  @override
  Future removeTransaction(int id) {
    return _$removeTransactionAsyncAction
        .run(() => super.removeTransaction(id));
  }

  late final _$createTransactionAsyncAction = AsyncAction(
      '_FinancialControllerBase.createTransaction',
      context: context);

  @override
  Future createTransaction() {
    return _$createTransactionAsyncAction.run(() => super.createTransaction());
  }

  late final _$updateTransactionAsyncAction = AsyncAction(
      '_FinancialControllerBase.updateTransaction',
      context: context);

  @override
  Future updateTransaction(int id) {
    return _$updateTransactionAsyncAction
        .run(() => super.updateTransaction(id));
  }

  late final _$_FinancialControllerBaseActionController =
      ActionController(name: '_FinancialControllerBase', context: context);

  @override
  dynamic changeLoading(dynamic value) {
    final _$actionInfo = _$_FinancialControllerBaseActionController.startAction(
        name: '_FinancialControllerBase.changeLoading');
    try {
      return super.changeLoading(value);
    } finally {
      _$_FinancialControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
transactions: ${transactions},
wallet: ${wallet}
    ''';
  }
}
