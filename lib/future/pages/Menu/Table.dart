import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/List_Local.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/future/component/date_Dropdown.dart';
import 'package:smaill_project/future/component/input_TextUpdate.dart';
import 'package:smaill_project/future/component/priorities.dart';
import 'package:smaill_project/future/data/MyDB.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int onRow = 10;
  void _setState(VoidCallback fn) {
    setState(fn);
  }

  MyDB mydb = MyDB();
  bool checkData = false;
  List<Map> listItems = [];
  List<Map> listModel = [];
  bool check = false;
  late DateDrop startDateDrop;
  late DateDrop endDateDrop;
  @override
  void initState() {
    getItems();

    super.initState();
    startDateDrop = DateDrop(
      filedname: "Start",
      value: (value) {
        setState(() {
          start.text = value;
        });
      },
    );

    endDateDrop = DateDrop(
      filedname: "End",
      value: (value) {
        setState(() {
          end.text = value;
        });
      },
    );
  }

  final start = TextEditingController();
  final end = TextEditingController();
  final searchText = TextEditingController();
  bool checkTable = false;
  int id = 0;
  String prosID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: 40,
          child: TextFormField(
            controller: searchText,
            onChanged: (value) {
              setState(() {
                checkTable = true;
                searchbyDate(value);
              });
            },
            style: const TextStyle(color: Colors.black, fontSize: 12),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(9),
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    checkTable = true;
                    searchbyDate(searchText.text);
                  });
                },
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: iconblue,
                      border: Border.all(width: 0.5, color: greyColor),
                    ),
                    child: const Icon(Icons.search, color: whileColor)),
              ),
              icon: const SizedBox(width: 10),
              suffix: IconButton(
                onPressed: () {
                  setState(() {
                    searchText.clear();
                    getItems();
                  });
                },
                icon: const Icon(Icons.cancel_outlined, color: greyColor),
              ),
              border: InputBorder.none,
              hintText: '  Search listing here...',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Priorities(
                          value: (value) {
                            setState(() {
                              List<dynamic> values = value!.split(',');
                              searchText.text = values[1];

                              checkTable = true;
                              searchbyDate(prosID);
                            });
                          },
                          lable: 'Proiries')),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // checkTable = true;
                          // searchbyDate(searchText.text);
                          checkTable = false;
                          searchText.clear();
                          getItems();
                          endDateDrop.clear();
                          startDateDrop.clear();
                        });
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: iconblue,
                            border: Border.all(width: 0.5, color: greyColor),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, color: whileColor),
                              Text('Refrech',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: whileColor))
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  startDateDrop,
                  const SizedBox(width: 10),
                  endDateDrop,
                ],
              ),
            ),
            SizedBox(
              child: PaginatedDataTable(
                // headingRowHeight: 6,
                horizontalMargin: 5.0,
                arrowHeadColor: Colors.blueAccent[300],
                columns: [
                  for (int i = 0; i < listTable.length; i++)
                    DataColumn(
                      label: Text(
                        listTable[i]['title'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 11, 67)),
                      ),
                    ),
                ],
                dataRowHeight: 50,
                rowsPerPage: onRow,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    onRow = value!;
                  });
                },
                source: _DataSource(
                  data: listModel,
                  countRow: listModel.length,
                  context: context,
                  setStateCallback: _setState,
                  backValue: (value) {
                    setState(() {
                      if (value == 'delete' || value == 'update') {
                        if (checkTable == true) {
                          searchbyDate(searchText.text);
                        } else {
                          getItems();
                        }
                      } else {
                        List<String> valuelist = value.split(',');
                        if (valuelist[1] == "1") {
                          mydb.done(int.parse(valuelist[0]), 0);
                        } else {
                          mydb.done(int.parse(valuelist[0]), 1);
                        }
                        if (checkTable == true) {
                          searchbyDate(searchText.text);
                        } else {
                          getItems();
                        }
                      }
                    });
                  },
                  mydb: mydb,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchbyDate(String query) async {
    if (checkTable == true) {
      listItems = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    }
    final lowerCaseQuery = query.toLowerCase();
    List<Map> searchedItems = listItems.where((property) {
      final id = property['id'].toString().toLowerCase();
      final item = property['items'].toString().toLowerCase();
      final proName = property['pro_name'].toString().toLowerCase();
      final createDate = property['create_date'].toString().toLowerCase();
      // final proID = property['pro_id'].toString().toLowerCase();
      return id.contains(lowerCaseQuery) ||
          item.contains(lowerCaseQuery) ||
          proName.contains(lowerCaseQuery) ||
          createDate.contains(lowerCaseQuery);
      // proID.contains(lowerCaseQuery);
    }).toList();

    DateTime startDate;
    DateTime endDate;
    try {
      startDate = DateTime.parse(start.text);
      endDate = DateTime.parse(end.text);
    } catch (e) {
      setState(() {
        listModel = searchedItems;
      });
      return;
    }

    List<Map> filteredRecords = searchedItems.where((record) {
      DateTime verbalDate;
      try {
        verbalDate = DateTime.parse(record["create_date"].toString());
      } catch (e) {
        print('Invalid date format in record: ${record["create_date"]}');
        return false;
      }
      return (verbalDate.isAtSameMomentAs(startDate) ||
              verbalDate.isAfter(startDate)) &&
          (verbalDate.isAtSameMomentAs(endDate) ||
              verbalDate.isBefore(endDate));
    }).toList();

    setState(() {
      listModel = filteredRecords;
    });
  }

  Future<void> getItems() async {
    await mydb.createUser();
    listItems = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    setState(() {
      listModel = listItems;
    });
  }
}

class _DataSource extends DataTableSource {
  late List<Map> data;
  final int countRow;
  final BuildContext context;
  final Function setStateCallback;

  final MyDB mydb;

  final OnChangeCallback backValue;
  _DataSource(
      {required this.data,
      required this.countRow,
      required this.context,
      required this.setStateCallback,
      required this.mydb,
      required this.backValue});

  int selectindex = -1;
  Future<void> getItems() async {
    await mydb.createUser();
    data = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    setStateCallback(() {
      data;
    });
  }

  bool checkback = false;
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index % 2 == 0
              ? const Color.fromARGB(168, 181, 181, 183)
              : Colors.white;
        },
      ),
      cells: [
        buildDataCell("${index + 1}", true, index),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  setStateCallback(() {
                    checkback = false;
                    if (checkback == false) {
                      backValue(
                          "${item['id'].toString()},${item['checks'].toString()}");
                    }
                  });
                },
                icon: (item['checks'] == 0)
                    ? const Icon(Icons.check_box_outline_blank,
                        color: greyColor)
                    : const Icon(Icons.check_box_outlined, color: greyColor)),
            TextInputUpdate(
                index: index,
                backvalue: (value) {
                  setStateCallback(() {
                    checkback = true;
                    if (checkback == true) {
                      backValue(value);
                    }
                  });
                },
                list: data),
            IconButton(
                color: redColor,
                onPressed: () async {
                  AwesomeDialog(
                    width: 400,
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    headerAnimationLoop: false,
                    title: 'Do you want to delete?',
                    // desc: "",

                    btnOkOnPress: () async {
                      await mydb.delelteIem(item['id']);
                      setStateCallback(() {
                        checkback = true;

                        if (checkback == true) {
                          backValue("delete");
                        }
                      });
                    },
                    btnCancelOnPress: () {},
                    btnCancelColor: greyColorSmall,
                    btnOkColor: greyColorSmall,
                  ).show();
                },
                icon: const Icon(Icons.delete, size: 30)),
          ],
        )),
        buildDataCell(item['create_date'].toString(), true, index),
        buildDataCell(item['id'].toString(), true, index),
        buildDataCell(item['items'], true, index),
        buildDataCell(item['pro_name'], true, index),
      ],
    );
  }

  DataCell buildDataCell(String text, bool fw, int index) {
    return DataCell(
      onTap: () {},
      Text(
        text,
        style: TextStyle(
            fontSize: 13,
            color: greyColor,
            fontWeight: fw ? FontWeight.bold : null),
      ),
    );
  }

  @override
  int get rowCount => countRow;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
