// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/future/data/MyDB.dart';

class TextInputUpdate extends StatefulWidget {
  const TextInputUpdate({
    Key? key,
    required this.label,
    required this.index,
    required this.backvalue,
    required this.list,
  }) : super(key: key);
  final String label;
  final List list;
  final int index;
  final OnChangeCallback backvalue;

  @override
  State<TextInputUpdate> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputUpdate> {
  MyDB mydb = MyDB();
  Future<void> getItems() async {
    await mydb.createUser();
    List<Map> listItems = await mydb.db.rawQuery('SELECT * FROM ItemList4');
    setState(() {
      widget.backvalue(listItems);
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.list[widget.index]['items'];
    super.initState();
  }

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
                decoration: InputDecoration(
                  suffixIcon: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: iconblue),
                      onPressed: () async {
                        await mydb.createUser();
                        await mydb.updateItem(
                            widget.list[widget.index]['id'],
                            controller.text,
                            widget.list[widget.index]['checks']);
                        getItems();
                        setState(() {
                          controller.clear();
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: whileColor),
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
