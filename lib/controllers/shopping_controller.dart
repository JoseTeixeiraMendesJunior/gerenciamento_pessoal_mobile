import 'package:flutter/cupertino.dart';
import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../repositories/global_api.dart';
part 'shopping_controller.g.dart';

class ShoppingController = _ShoppingControllerBase with _$ShoppingController;

abstract class _ShoppingControllerBase with Store {


  final GlobalApi rep = GetIt.I.get<GlobalApi>();

  TextEditingController name = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController itemQuantity = TextEditingController();

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  ObservableList<ShoppingListModel> shoppingList = ObservableList<ShoppingListModel>();

  @observable
  List<Items> items = [];

  @action
  addItem() {
    Items temp = Items(
      name: itemName.text,
      quantity: int.parse(itemQuantity.text),
    );

    items.add(temp);

    itemName.clear();
    itemQuantity.clear();
    // itemName.text = '';
    // itemQuantity.text = '';
  }

  @action
  getItems() async {
    changeLoading(true);
    List<ShoppingListModel> temp = await rep.getShoppingList();
    shoppingList = temp.asObservable();
    changeLoading(false);
  }

  @action
  saveItem(String method, {int? id}) async {
    changeLoading(true);
    ShoppingListModel data = ShoppingListModel(
      id: id,
      name: name.text,
      items: items,
    );
    
    var res = method == 'create' ? 
    await rep.createShoppingList(data) : 
    await rep.updateShoppingList(id!, data);

    if(res != false && method == 'update') {
      shoppingList.removeWhere((element) => element.id == data.id);
    }

    if(rep is ShoppingListModel) {
      shoppingList.insert(0, data);
    }
    changeLoading(false);
  }


  disposeRegister() {
    name.clear();
    itemName.clear();
    itemQuantity.clear();
    items = [];
  }
}