import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/future/component/priorities.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/integration/widget_keys.dart';

class TextInputUpdate extends StatefulWidget {
  const TextInputUpdate({
    Key? key,
    required this.index,
    required this.backvalue,
    required this.list,
  }) : super(key: key);
  final List list;
  final int index;
  final OnChangeCallback backvalue;

  @override
  State<TextInputUpdate> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputUpdate> {
  MyDB mydb = MyDB();

  TextEditingController controller = TextEditingController();
  int proID = 0;
  String proName = "";
  @override
  void initState() {
    super.initState();
  }

  void main() {
    setState(() {
      controller.text = widget.list[widget.index]['items'];
      proName = widget.list[widget.index]['pro_name'];
      proID = widget.list[widget.index]['pro_id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        // key: WidgetKeys.buttonupdate,
        color: greenColor,
        onPressed: () async {
          main();
          showUpdate(widget.index, widget.list);
        },
        icon: const Icon(Icons.edit, size: 30));
  }

  Future showUpdate(int index, List list) {
    return showDialog(
        context: context,
        builder: (context) => Center(
            child: AlertDialog(
                backgroundColor: whileColor,
                title: Text('No.$index',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whileColor),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              fillColor: whileColor,
                              filled: true,
                              labelText: "Update",
                              labelStyle: const TextStyle(
                                  color: greyColor, fontSize: 16),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
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
                        const SizedBox(height: 10),
                        Priorities(
                          lable:
                              widget.list[widget.index]['pro_name'].toString(),
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
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: iconblue),
                                onPressed: () async {
                                  await mydb.createUser();
                                  await mydb.updateItem(
                                      widget.list[widget.index]['id'],
                                      controller.text,
                                      widget.list[widget.index]['checks'],
                                      proID,
                                      proName);
                                  widget.backvalue('update');
                                  setState(() {
                                    Navigator.pop(context);
                                    controller.clear();
                                  });
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(color: whileColor),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
