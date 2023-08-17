// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingListController on _ShoppingListControllerBase, Store {
  late final _$listAtom =
      Atom(name: '_ShoppingListControllerBase.list', context: context);

  @override
  ObservableList<ShopItems> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<ShopItems> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  late final _$_ShoppingListControllerBaseActionController =
      ActionController(name: '_ShoppingListControllerBase', context: context);

  @override
  dynamic selectItem(int index) {
    final _$actionInfo = _$_ShoppingListControllerBaseActionController
        .startAction(name: '_ShoppingListControllerBase.selectItem');
    try {
      return super.selectItem(index);
    } finally {
      _$_ShoppingListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getList(ShoppingListModel shoppingList) {
    final _$actionInfo = _$_ShoppingListControllerBaseActionController
        .startAction(name: '_ShoppingListControllerBase.getList');
    try {
      return super.getList(shoppingList);
    } finally {
      _$_ShoppingListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
