import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
// import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryItemsNotifier() : super([]);

  void addItem(GroceryItem item) {
    state = [...state, item];
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryItemsNotifier, List<GroceryItem>>(
        (ref) => GroceryItemsNotifier());

final categoryProvider = Provider((ref) => categories);
