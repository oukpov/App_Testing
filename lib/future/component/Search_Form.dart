import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class SearchForm extends StatefulWidget {
  const SearchForm({super.key, required this.onChanged, required this.list});
  final FormFieldSetter<String> onChanged;
  final OnChangeCallback list;
  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: whileColor,
          border: Border.all(width: 0.5, color: greyColor)),
      child: TextFormField(
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffix: IconButton(
              onPressed: () {
                setState(() {
                  controller.clear();
                  widget.list(1);
                });
              },
              icon: const Icon(Icons.remove_circle_outline,
                  color: greyColorSmall)),
          fillColor: whileColor,
          hintText: "  Search",
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whileColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: whileColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
