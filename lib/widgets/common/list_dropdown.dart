import 'package:edupot/widgets/common/input_button.dart';
import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart'; // Ensure you have this path correct for your theme

class CustomSearchDropdown extends StatefulWidget {
  const CustomSearchDropdown({super.key});

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  final List<String> _dropdownValues = [
    'One',
    'Two',
    'Three',
    'Four'
  ]; // Example items
  List<String> _filteredDropdownValues = [];
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _filteredDropdownValues = _dropdownValues;
  }

  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _filteredDropdownValues = _dropdownValues
                        .where((item) =>
                            item.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredDropdownValues.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_filteredDropdownValues[index]),
                      onTap: () {
                        setState(() {
                          _selectedValue = _filteredDropdownValues[index];
                          Navigator.of(context).pop();
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputButton(
      onPressed: _openSearchDialog,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedValue ?? "Select an Option",
            style: EduPotDarkTextTheme.headline2(1),
          ),
        ],
      ),
    );
  }
}
