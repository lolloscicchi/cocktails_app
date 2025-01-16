import 'package:cocktails_app/theme/colors.dart';
import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  final List<String> categories;
  final Function(String?, bool?) onApplyFilters;

  FilterPanel({required this.categories, required this.onApplyFilters});

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? _selectedCategory;
  bool? _isAlcoholic;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: widget.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<bool>(
                value: _isAlcoholic,
                items: [
                  DropdownMenuItem(value: null, child: Text('Tutti')),
                  DropdownMenuItem(value: true, child: Text('Alcolico')),
                  DropdownMenuItem(value: false, child: Text('Analcolico')),
                ],
                onChanged: (value) {
                  setState(() {
                    _isAlcoholic = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(_selectedCategory, _isAlcoholic);
                  Navigator.pop(context);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                child: const Text(
                  'Applica Filtri',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
