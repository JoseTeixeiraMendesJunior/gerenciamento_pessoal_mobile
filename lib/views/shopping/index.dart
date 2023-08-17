import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/shopping_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/shopping_list_model.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:gerenciamento_pessoal_mobile/resources/widgets/comuns.dart';
import 'package:gerenciamento_pessoal_mobile/views/shopping/form.dart';
import 'package:gerenciamento_pessoal_mobile/views/shopping/list.dart';
import 'package:get_it/get_it.dart';

class ShoppingScrean extends StatefulWidget {
  const ShoppingScrean({super.key});

  @override
  State<ShoppingScrean> createState() => _ShoppingScreanState();
}

class _ShoppingScreanState extends State<ShoppingScrean> {
  final shoppingController = GetIt.I.get<ShoppingController>();

  @override
  void initState() {
    super.initState();
    shoppingController.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Lista de Compras', style: TextStyle(color: Colors.white),),
            ],
          ),
          backgroundColor: GlobalColors.navy,
        ),
        body: Column(
          children: [
              if(shoppingController.isLoading)
                ...[const Center(child: LoadingWidget())]
              else if(shoppingController.shoppingList.isEmpty) 
                ...[const Center(child: EmptyWidget())]
              else ...[ShoppingListBody(
                shoppingList: shoppingController.shoppingList,
                shoppingController: shoppingController,
                )],
      
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const ShoppingListForm())),
          backgroundColor: GlobalColors.navy,
          elevation: 5,
          child: const Icon(Icons.add, color: Colors.white,),
          ),
      );
    });
  }
}

class ShoppingListBody extends StatelessWidget {
  const ShoppingListBody({
    required this.shoppingList,
    required this.shoppingController,
    super.key});
  
  final List<ShoppingListModel> shoppingList;
  final ShoppingController shoppingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          ...shoppingList.map((element) {
            return ShoppingListElement(shoppingItem: element, shoppingController: shoppingController,);
          })
        ],
      ),
    );
  }
}

class ShoppingListElement extends StatelessWidget {
  const ShoppingListElement({
      required this.shoppingController,
      required this.shoppingItem,
      super.key
    });

    final ShoppingListModel shoppingItem;
    final ShoppingController shoppingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
              ShoppingListView(shoppingList: shoppingItem),));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: GlobalColors.navy, width: 3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart_rounded, color: GlobalColors.navy,),
                Column(
                  children: [
                    Text(shoppingItem.name ?? ''),
                    Text.rich(
                      TextSpan(
                        text: 'Itens: ',
                        children: [TextSpan(text: shoppingItem.items?.length.toString())] 
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await shoppingController.removeShoppingList(shoppingItem.id!);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red,))
              ],
            )
          ),
        ),
      );
  }
}
