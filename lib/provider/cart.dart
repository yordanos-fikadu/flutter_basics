import 'package:demo/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.item.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${cart.item[index].name}'),
                title: Text('${cart.item[index].number}'),
                trailing: IconButton(
                    onPressed: () => cart.delete(index),
                    icon: Icon(Icons.delete)),
              );
            },
          );
        },
      ),
    );
  }
}
