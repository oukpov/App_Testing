import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/priorities.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/integration/widget_keys.dart';

typedef OnChangeCallback = void Function(dynamic value);

class SearchForm extends StatefulWidget {
  const SearchForm({
    super.key,
    required this.onChanged,
    required this.list,
  });
  final FormFieldSetter<String> onChanged;
  final OnChangeCallback list;
  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController controller = TextEditingController();
  TextEditingController addcontroller = TextEditingController();
  MyDB mydb = MyDB();
  int proID = 0;
  String proName = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: whileColor,
                border: Border.all(width: 0.5, color: greyColor)),
            child: TextFormField(
              key: WidgetKeys.search,
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
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: TextButton(
              key: WidgetKeys.buttonAdd,
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: iconblue),
              onPressed: () async {
                showAddItem();
              },
              child: const Icon(Icons.add, size: 30, color: whileColor)),
        ),
      ],
    );
  }

  Future showAddItem() {
    return showDialog(
        context: context,
        builder: (context) => Center(
                child: AlertDialog(
              backgroundColor: whileColor,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: TextFormField(
                        controller: addcontroller,
                        key: WidgetKeys.itemName,
                        decoration: InputDecoration(
                          fillColor: whileColor,
                          filled: true,
                          labelText: "Add New Item",
                          labelStyle:
                              const TextStyle(color: greyColor, fontSize: 16),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: greyColor,
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
                    const SizedBox(height: 10),
                    Priorities(
                      lable: '',
                      value: (value) {
                        setState(() {
                          List<dynamic> values = value!.split(',');
                          proID = int.parse(values[0]);
                          proName = values[1];
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: greyColorSmall),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: whileColor),
                            )),
                        TextButton(
                            key: WidgetKeys.saveAddItem,
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: iconblue),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              final userItem = addcontroller.text;
                              await mydb.createUser();
                              await mydb.db.rawInsert(
                                  "INSERT INTO list_To_do_Table(items, checks, pro_id, pro_name) VALUES (?,?,?,?);",
                                  [userItem, 0, proID, proName]);
                              // getItems();
                              setState(() {
                                widget.list(1);
                                addcontroller.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: whileColor),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
