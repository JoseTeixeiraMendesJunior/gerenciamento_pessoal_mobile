import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/shopping_list_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/shopping_items.dart';
import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:get_it/get_it.dart';

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
  final ShoppingListController shoppingListController =
      GetIt.I.get<ShoppingListController>();

  @override
  void initState() {
    shoppingListController.getList(widget.shoppingList);
    super.initState();
  }

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
      body: ShoppingListList(
          items: shoppingListController.list,
          shoppingListController: shoppingListController),
    );
  }
}

class ShoppingListList extends StatelessWidget {
  const ShoppingListList(
      {required this.items, required this.shoppingListController, super.key});

  final List<ShopItems> items;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            ShopItems item = items[index];
            return InkWell(
              onTap: () => shoppingListController.selectItem(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: item.selected == true
                              ? GlobalColors.olive
                              : GlobalColors.gray)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: item.selected == true
                            ? GlobalColors.olive
                            : GlobalColors.gray,
                        size: 24,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.name ?? 'Sem nome',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text.rich(TextSpan(text: 'Quantidade: ', children: [
                            TextSpan(
                                text: item.quantity != null
                                    ? item.quantity.toString()
                                    : '0')
                          ]))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
