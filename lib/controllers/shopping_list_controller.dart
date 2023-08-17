import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';
import 'package:mobx/mobx.dart';

import '../models/shopping_items.dart';
part 'shopping_list_controller.g.dart';

class ShoppingListController = _ShoppingListControllerBase with _$ShoppingListController;

abstract class _ShoppingListControllerBase with Store {

  @observable
  ObservableList<ShopItems> list = ObservableList<ShopItems>();

  @action
  selectItem(int index) {
    ShopItems temp = list[index];

    temp.selected = !temp.selected!;

    list.removeAt(index);
    list.insert(index, temp);
  }

  @action
  getList(ShoppingListModel shoppingList) {
    var items = shoppingList.items!;

    List<ShopItems> temp = [];

    for(Items item in items ) {
      temp.add(ShopItems.fromJson(item.toJson()));
    }

    list = temp.asObservable();
  }
  
}