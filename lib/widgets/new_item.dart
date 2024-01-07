import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/categories_provider.dart';
import 'package:string_capitalize/string_capitalize.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  String _enteredName = "";
  int _enteredQuantity = 1;
  final _formKey = GlobalKey<FormState>();

  void _saveItem(Category selectedCategory, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref.read(groceryProvider.notifier).addItem(GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName.capitalize(),
          quantity: _enteredQuantity,
          category: selectedCategory));

      Navigator.pop(context);
    }
  }

  var selectedCategory = categories[Categories.convenience];

  @override
  Widget build(BuildContext context) {
    // final categoriesList = ref.watch(categoryProvider);

    // var _selectedCategory = categoriesList.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(),
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text(
                    "Name",
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return "Must be between 1 and 50 Charachters.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          "Quanitity",
                        ),
                      ),
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                      initialValue: _enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Must be a valid Positive Number.";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(category.value.title)
                                ],
                              ))
                      ],
                      onChanged: (value) {
                        // updateState(value!);
                        selectedCategory = value!;
                        // print(value);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text(
                      "Reset",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveItem(selectedCategory!, ref);
                    },
                    child: const Text(
                      "Add Item",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
