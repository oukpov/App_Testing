// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/integration/widget_keys.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    required this.label,
    required this.backvalue,
  }) : super(key: key);
  final String label;
  final OnChangeCallback backvalue;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  MyDB mydb = MyDB();
  Future<void> getItems() async {
    await mydb.createUser();
    List<Map> listItems = await mydb.db.rawQuery('SELECT * FROM ItemList4');
    setState(() {
      widget.backvalue(listItems[listItems.length - 1]);
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 10,
            child: SizedBox(
              child: TextFormField(
                controller: controller,
                key: WidgetKeys.itemName,
                decoration: InputDecoration(
                  suffixIcon: TextButton(
                      key: WidgetKeys.saveButton,
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: iconblue),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final userItem = controller.text;
                        await mydb.createUser();
                        await mydb.db.rawInsert(
                            "INSERT INTO ItemList4(items, checks) VALUES (?,?);",
                            [userItem, 0]);
                        getItems();
                        setState(() {
                          controller.clear();
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: whileColor,
                      )),
                  fillColor: whileColor,
                  filled: true,
                  labelText: widget.label,
                  labelStyle: TextStyle(color: greyColor, fontSize: 16),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: whileColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
