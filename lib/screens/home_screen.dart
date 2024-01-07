import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_list/providers/categories_provider.dart';
import 'package:shopping_list/widgets/listview_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _addItem(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewItem()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(groceryProvider).toList();

    Widget fallbackScreen = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network("https://lottie.host/22bbebab-2491-45cd-868a-d7e0d66d61d5/6wfu7PNsK5.json"),
          Text(
            "Oops..",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            "No Item Found",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );

    Widget mainScreen = ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, item) {
          // print(itemsList.elementAt(item));
          return ListViewGroceryItem(itemsList.elementAt(item));
        });
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your Groceries",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _addItem(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: (itemsList.isEmpty) ? fallbackScreen : mainScreen);
  }
}
