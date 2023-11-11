import 'package:demo/provider/cart.dart';
import 'package:demo/provider/item.dart';
import 'package:demo/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Catalog extends StatefulWidget {
  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<int> numbers = [1, 2, 3];
  List<String> name = ['one', 'two', 'three'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Cart(),
            )),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${numbers[index]}'),
            title: Consumer<CartModel>(
              builder: (context, cart, child) => OutlinedButton(
                onPressed: () => cart.add(Item(
                  name: name[index],
                  number: numbers[index],
                )),
                child: Text('Add'),
              ),
            ),
          );
        },
      ),
    );
  }
}
