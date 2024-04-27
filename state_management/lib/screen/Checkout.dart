// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../model/Item.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    //List<Item> products = context.watch<ShoppingCart>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Counter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;

    return products.isEmpty
        ? const Center(child: Text('No items to checkout!'))
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(Icons.food_bank),
                          title: Text(products[index].name),
                          trailing: Text(products[index].price.toString()),
                        );
                      })),
              const Divider(
                height: 4,
                color: Colors.black,
              ),
              computeCost(),
              Flexible(
                  child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Payment Successful!"),
                                  duration:
                                      Duration(seconds: 1, milliseconds: 100)));

                          Navigator.pushNamed(context, "/products");
                        },
                        child: const Text("Pay Now!"))
                  ],
                ),
              )),
            ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total Cost to Pay: ${cart.cartTotal}");
    });
  }
}
