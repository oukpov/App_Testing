import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/integration/widget_keys.dart';

// typedef OnChangeCallback = void Function(String?);

class Priorities extends StatefulWidget {
  const Priorities({super.key, required this.value, required this.lable});
  final OnChangeCallback value;
  final String lable;
  @override
  State<Priorities> createState() => _PrioritiesState();
}

class _PrioritiesState extends State<Priorities> {
  List<Map<String, dynamic>> prioritiesList = [
    {"id": 0, "title": 'None'},
    {"id": 1, "title": 'High'},
    {"id": 2, "title": 'Middle'},
    {"id": 3, "title": 'Low'}
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: DropdownButtonFormField<String>(
        key: WidgetKeys.dropdown,
        onChanged: (String? newValue) {
          setState(() {
            widget.value(newValue);
          });
        },
        items: prioritiesList
            .map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
          return DropdownMenuItem<String>(
            value: item['id'].toString() + "," + item['title'],
            child: Text(item['title']),
          );
        }).toList(),
        icon: const Icon(Icons.arrow_drop_down, color: greyColor),
        decoration: InputDecoration(
          fillColor: whileColor,
          filled: true,
          labelText: widget.lable,
          hintText: 'Select one',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          prefixIcon:
              const Icon(Icons.priority_high_outlined, color: greyColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: greyColorSmall, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: greyColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
