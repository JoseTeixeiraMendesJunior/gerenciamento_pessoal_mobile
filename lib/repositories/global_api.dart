import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/tasks_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/transactions_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/user_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/wallet.dart';
import 'package:get_it/get_it.dart';

import '../provider/global_request.dart';

class GlobalApi {
  GlobalProvider provider = GetIt.I.get<GlobalProvider>();

  //Auth
  Future<UserModel> login(data) async {
    var ret = await provider.sendPost("login", data, "login");

    UserModel user = UserModel();
    if (ret != false) {
      user = UserModel.fromJson(ret);
      return user;
    }

    throw Exception('failed');
  }

  Future<bool> register(data) async {
    var ret = await provider.sendPost("register", data, "register");

    return ret != false;
  }

  // Shopping Lists
  Future<List<ShoppingListModel>> getShoppingList() async {
    List<ShoppingListModel> shoppingListModel = [];

    var ret = await provider.sendGet("shopping_lists");

    if (ret != false) {
      ret.forEach((e) => shoppingListModel.add(ShoppingListModel.fromJson(e)));
    }

    return shoppingListModel;
  }

  Future<bool> deleteShoppingList(int id) async {
    var ret = await provider.sendDelete("shopping_lists/$id");

    return ret != false;
  }

  Future<ShoppingListModel> updateShoppingList(int id, data) async {
    var ret = await provider.sendPut("shopping_lists/$id", data, "update");

    ShoppingListModel shopping = ShoppingListModel();

    if( ret != false) {
      shopping = ShoppingListModel.fromJson(ret);
    }

    return shopping;
  }

  Future<ShoppingListModel>createShoppingList(data) async {
    var ret = await provider.sendPost("shopping_lists", data, "create");
    ShoppingListModel shopping = ShoppingListModel();


    if( ret != false) {
      shopping = ShoppingListModel.fromJson(ret);
    }

    return shopping;
  }

  //Tasks
  //todo criar model de tasks
    Future<List<TasksModel>> getTasks() async {
    List<TasksModel> tasksModel = [];

    var ret = await provider.sendGet("tasks");

    if (ret != false) {
      ret.forEach((e) => tasksModel.add(TasksModel.fromJson(e)));
    }

    return tasksModel;
  }

  Future<bool> deleteTasks(int id) async {
    var ret = await provider.sendDelete("tasks/$id");

    return ret != false;

  }

  Future<bool> updateTasks(int id, data) async {
    var ret = await provider.sendPut("tasks/$id", data, "update");

    return ret != false;
  }

  Future<bool> createTasks(int id, data) async {
    var ret = await provider.sendPost("tasks", data, "create");

    return ret != false;

  }

  //Financial Management
  Future<List<TransactionModel>> getTransactions() async {
    List<TransactionModel> transactions = [];

    var ret = await provider.sendGet("transactions");

    if (ret != false) {
      ret.forEach((e) => transactions.add(TransactionModel.fromJson(e)));
    }

    return transactions;
  }

  Future<bool> deleteTransactions(int id) async {
    var ret = await provider.sendDelete("transactions/$id");

    return ret != false;

  }

  Future<bool> updateTransactions(int id, data) async {
    var ret = await provider.sendPut("transactions/$id", data, "update");

    return ret != false;
  }

  Future<TransactionModel>createTransactions(data) async {
    var ret = await provider.sendPost("transactions", data, "create");
    TransactionModel transaction = TransactionModel();


    if( ret != false) {
      transaction = TransactionModel.fromJson(ret);
    }

    return transaction;
  }

  getWallet() async {
    WalletModel wallet = WalletModel();

    var ret = await provider.sendGet("wallet");

    if (ret != false) {
      wallet = WalletModel.fromJson(ret);
      return wallet;
    }

    return false;
  }
}
