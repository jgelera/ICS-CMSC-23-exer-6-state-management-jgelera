// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../model/Item.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          computeCost(),
          const Divider(
            height: 4,
            color: Colors.black,
          ),
          Flexible(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll();
                    },
                    child: const Text("Reset"))
              ],
            ),
          )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/products");
              },
              child: const Text("Go back to Product Catalog"))
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";

    return products.isEmpty
        ? const Text('No items yet!')
        : Expanded(
            child: Column(
            children: [
              Flexible(child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.food_bank),
                  title: Text(products[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      productname = products[index].name;
                      context.read<ShoppingCart>().removeItem(productname);

                      if (products.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$productname removed!"),
                          duration:
                              const Duration(seconds: 1, milliseconds: 100),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Cart Empty!"),
                          duration: Duration(seconds: 1, milliseconds: 100),
                        ));
                      }
                    },
                  ),
                );
              }))
            ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total: ${cart.cartTotal}");
    });
  }
}
