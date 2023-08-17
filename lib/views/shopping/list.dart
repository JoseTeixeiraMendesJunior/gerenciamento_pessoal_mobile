import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({
      required this.shoppingList,
      super.key,
    });

  final ShoppingListModel shoppingList;
  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
            widget.shoppingList.name ?? "Lista de compras",
            style: const TextStyle(color: Colors.white),
          ),
      ),
      body: ShoppingListList(items: widget.shoppingList.items!,),
    );
  }
}

class ShoppingListList extends StatelessWidget {
  const ShoppingListList({
      required this.items,
      super.key
    });
  
  final List<Items> items;

  @override
  Widget build(BuildContext context) {
    return Column(

    );
  }
}