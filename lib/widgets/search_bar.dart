import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final Function() onClear;
  final TextEditingController controller;

  const MySearchBar(
      {super.key,
      required this.onSearch,
      required this.onClear,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cerca cocktail...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clearComposing();
              onClear();
            },
          ),
          border: OutlineInputBorder(),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
