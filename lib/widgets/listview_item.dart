import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery_item.dart';

class ListViewGroceryItem extends ConsumerWidget {
  const ListViewGroceryItem(this.item, {super.key});
  final GroceryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Container(
        color: item.category.color,
        width: 20,
        height: 20,
      ),
      title: Text(
        item.name,
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: Text(
        item.quantity.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
