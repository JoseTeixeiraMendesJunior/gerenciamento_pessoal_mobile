import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/shopping_controller.dart';
import 'package:get_it/get_it.dart';

class ShoppingListForm extends StatefulWidget {
  const ShoppingListForm({super.key});

  @override
  State<ShoppingListForm> createState() => _ShoppingListFormState();
}

class _ShoppingListFormState extends State<ShoppingListForm> {

  final shoppingController = GetIt.I.get<ShoppingController>();

  @override
  void initState() {
    shoppingController.disposeRegister();  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.purple,
        title: const Text('Nova Lista', style: TextStyle(color: Colors.white),),
      ),
      body: Observer(
        builder: (_) {
          return Column(
            // mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, right: 32, left: 32),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Nome da lista'),
                    controller: shoppingController.name,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32, right: 32, left: 32),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Nome do item'),
                    controller: shoppingController.itemName,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: 'Quantidade'),
                          controller: shoppingController.itemQuantity,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(onPressed: () => shoppingController.addItem(),
                        icon: const Icon(Icons.add_box), color: Colors.green, iconSize: 38,),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool res = await shoppingController.saveItem("create");

                        if(res == true && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Salvar'),
                  )
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: shoppingController.items.length,
                    itemBuilder: (context, index) => Observer(
                      builder: (_) { 
                        return Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Text(shoppingController.items[index].name!),
                                  const Spacer(),
                                  Text.rich(
                                    TextSpan(
                                      text: 'quantidade: ',
                                      children: [TextSpan(text: shoppingController.items[index].quantity.toString())] 
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          ],
                        );
                      }
                    )
                  ),
                ),
          ],
        );
      })
    );
  }
}