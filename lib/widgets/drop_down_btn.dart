import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownBtn extends StatelessWidget {
  final List<String> items;
  final String selectedItemtext;
  final Function(String?) onSelected;

  const DropDownBtn({
    super.key,
    required this.items,
    required this.selectedItemtext,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select an item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
              .toList(),
          value: items.contains(selectedItemtext) ? selectedItemtext : null, // Kiểm tra giá trị
          onChanged: (String? value) {
            if (value != null) {
              onSelected(value); // Chỉ gọi callback nếu giá trị không null
            }
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
