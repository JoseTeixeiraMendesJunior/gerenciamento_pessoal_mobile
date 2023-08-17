// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingController on _ShoppingControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ShoppingControllerBase.isLoading', context: context);

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

  late final _$shoppingListAtom =
      Atom(name: '_ShoppingControllerBase.shoppingList', context: context);

  @override
  ObservableList<ShoppingListModel> get shoppingList {
    _$shoppingListAtom.reportRead();
    return super.shoppingList;
  }

  @override
  set shoppingList(ObservableList<ShoppingListModel> value) {
    _$shoppingListAtom.reportWrite(value, super.shoppingList, () {
      super.shoppingList = value;
    });
  }

  late final _$itemsAtom =
      Atom(name: '_ShoppingControllerBase.items', context: context);

  @override
  ObservableList<Items> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Items> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$getItemsAsyncAction =
      AsyncAction('_ShoppingControllerBase.getItems', context: context);

  @override
  Future getItems() {
    return _$getItemsAsyncAction.run(() => super.getItems());
  }

  late final _$saveItemAsyncAction =
      AsyncAction('_ShoppingControllerBase.saveItem', context: context);

  @override
  Future saveItem(String method, {int? id}) {
    return _$saveItemAsyncAction.run(() => super.saveItem(method, id: id));
  }

  late final _$removeShoppingListAsyncAction = AsyncAction(
      '_ShoppingControllerBase.removeShoppingList',
      context: context);

  @override
  Future removeShoppingList(int id) {
    return _$removeShoppingListAsyncAction
        .run(() => super.removeShoppingList(id));
  }

  late final _$_ShoppingControllerBaseActionController =
      ActionController(name: '_ShoppingControllerBase', context: context);

  @override
  dynamic changeLoading(dynamic value) {
    final _$actionInfo = _$_ShoppingControllerBaseActionController.startAction(
        name: '_ShoppingControllerBase.changeLoading');
    try {
      return super.changeLoading(value);
    } finally {
      _$_ShoppingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addItem() {
    final _$actionInfo = _$_ShoppingControllerBaseActionController.startAction(
        name: '_ShoppingControllerBase.addItem');
    try {
      return super.addItem();
    } finally {
      _$_ShoppingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
shoppingList: ${shoppingList},
items: ${items}
    ''';
  }
}
