import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/integration/widget_keys.dart';

class Testing extends StatefulWidget {
  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final List<Map> listModel = [
    {'id': 1, 'items': 'Avocados', 'checks': 0},
    {'id': 2, 'items': 'Cranberry', 'checks': 0},
    {'id': 3, 'items': 'Dragonfruit', 'checks': 0},
    {'id': 4, 'items': 'Finger lime', 'checks': 0},
    {'id': 5, 'items': 'Grapefruit', 'checks': 0},
    {'id': 6, 'items': 'Horned melon', 'checks': 0},
    {'id': 7, 'items': 'Indian fig', 'checks': 0},
    {'id': 8, 'items': 'Jackfruit', 'checks': 0},
    {'id': 9, 'items': 'Kiwi', 'checks': 0},
    {'id': 10, 'items': 'Mango', 'checks': 0},
    {'id': 11, 'items': 'Muskmelon', 'checks': 0},
    {'id': 12, 'items': 'Nectarine', 'checks': 0},
    {'id': 13, 'items': 'Olive', 'checks': 0},
    {'id': 14, 'items': 'Papaya', 'checks': 0},
    {'id': 15, 'items': 'Pomegranate', 'checks': 0},
    {'id': 16, 'items': 'Raspberries', 'checks': 0},
    {'id': 17, 'items': 'Tangerine', 'checks': 0}
  ];
  MyDB mydb = MyDB();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ListView Test App'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.63,
              width: double.infinity,
              child: ListView.builder(
                key: WidgetKeys.listView,
                itemCount: listModel.length,
                itemBuilder: (context, index) {
                  var list = listModel[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (list['checks'] == 1)
                              ? greyColorSmall
                              : whileColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(index.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: (list['checks'] == 0)
                                          ? greyColor
                                          : whileColor,
                                      fontSize: 17)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (list['checks'] == 0) {
                                        mydb.done(list['id'], 1);
                                      } else {
                                        mydb.done(list['id'], 0);
                                      }
                                      // getItems();
                                    });
                                  },
                                  icon: (list['checks'] == 0)
                                      ? const Icon(
                                          Icons.check_box_outline_blank,
                                          color: greyColorSmall)
                                      : const Icon(Icons.check_box,
                                          color: whileColor)),
                              Text(
                                list['items'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (list['checks'] == 1)
                                        ? whileColor
                                        : greyColor),
                              ),
                              const Spacer(),
                              IconButton(
                                  color: greenColor,
                                  onPressed: () async {
                                    // showUpdate(index, listModel);
                                  },
                                  icon: const Icon(Icons.edit, size: 30)),
                              IconButton(
                                  color: redColor,
                                  onPressed: () async {
                                    await mydb.delelteIem(list['id']);
                                    // await getItems();
                                  },
                                  icon: const Icon(Icons.delete, size: 30)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
