import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:smaill_project/future/component/input_TextUpdate.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/integration/widget_keys.dart';
import '../../component/List_Local.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> listModel = [];

  String item = '';
  MyDB mydb = MyDB();

  @override
  void initState() {
    super.initState();
    getItems();
  }

  final controller = TextEditingController();
  List<Map> listItems = [];
  bool checkData = false;
  Future<void> itemWhere(String proID) async {
    listModel = listItems.where((property) {
      final item = property['pro_id'].toString().toLowerCase();
      final lowerCaseQuery = proID.toLowerCase();
      return item.contains(lowerCaseQuery);
    }).toList();
  }

  Future<void> getItems() async {
    await mydb.createUser();
    listItems = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    if (listItems.isEmpty && checkData == false) {
      for (int i = 0; i < listModelS.length; i++) {
        await mydb.db.rawInsert(
            "INSERT INTO list_To_do_Table(items, checks, pro_id, pro_name,create_date) VALUES (?,?,?,?,?);",
            [
              listModelS[i]['items'].toString(),
              0,
              listModelS[i]['pro_id'],
              listModelS[i]['pro_name'].toString(),
              listModelS[i]['create_date'].toString(),
            ]);
      }

      setState(() {
        listModel = listModelS;
        checkData = true;
      });
    } else {
      setState(() {
        listModel = listItems;
        checkData = true;
      });
    }
  }

  void searchProperties(String query) {
    setState(() {
      listModel = listItems.where((property) {
        final id = property['id'].toString().toLowerCase();
        final item = property['items'].toString().toLowerCase();
        final proName = property['pro_name'].toString().toLowerCase();
        final createDate = property['create_date'].toString().toLowerCase();

        final lowerCaseQuery = query.toLowerCase();
        return id.contains(lowerCaseQuery) ||
            item.contains(lowerCaseQuery) ||
            proName.contains(lowerCaseQuery) ||
            createDate.contains(lowerCaseQuery);
      }).toList();
    });
  }

  void getById(proID) async {
    listModel = await mydb.getItemValueById(proID);
    setState(() {
      listModel;
    });
  }

  void getByQuerty(proID, String qurty) async {
    // listModel = await mydb.getItemValueById(proID);
    listModel = await mydb.getItemValue(proID, qurty);
    setState(() {
      listModel;
    });
  }

  bool check = false;
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: WidgetKeys.homepage,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'To-do-list app',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user.png'),
          ),
          SizedBox(width: 30)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              SearchForm(list: (value) {
                setState(() {
                  if (value == 1) {
                    getItems();

                    check = false;
                  }
                });
              }, onChanged: (newValue) {
                setState(() {
                  check = true;
                  searchProperties(newValue!);
                });
              }),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (int i = 0; i < listColors.length; i++)
                    typePrio(listPro[i]['title'], listColors[i], i)
                ],
              ),
              Text(check.toString()),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.63,
                width: double.infinity,
                child: ListView.builder(
                  key: WidgetKeys.listview,
                  itemCount: listModel.length,
                  itemBuilder: (context, index) {
                    var list = listModel[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: (list['checks'] == 1) ? 3 : 0,
                                color: greyColor),
                            borderRadius: BorderRadius.circular(5),
                            color: (list['checks'] == 1)
                                ? whileColor
                                : (list['pro_id'] == 1)
                                    ? hightColor
                                    : (list['pro_id'] == 2)
                                        ? midleColor
                                        : lowColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: iconblue,
                                      radius: 20,
                                      child: Text("${index + 1}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: whileColor,
                                              fontSize: 17)),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(list['items'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor,
                                            fontSize: 18)),
                                    const Spacer(),
                                    IconButton(
                                        key: WidgetKeys.done,
                                        onPressed: () {
                                          setState(() {
                                            if (check == false) {
                                              if (list['checks'] == 0) {
                                                mydb.done(list['id'], 1);
                                              } else {
                                                mydb.done(list['id'], 0);
                                              }

                                              getItems();
                                              // getById(list['pro_id']);
                                            } else {
                                              if (list['checks'] == 0) {
                                                mydb.done(list['id'], 1);
                                              } else {
                                                mydb.done(list['id'], 0);
                                              }
                                              print('==> Click');
                                              getById(list['pro_id']);
                                              // getByQuerty(
                                              //     list['pro_id'], search);
                                            }
                                          });
                                        },
                                        icon: (list['checks'] == 0)
                                            ? const Icon(
                                                Icons.check_box_outline_blank,
                                                color: greyColor)
                                            : const Icon(
                                                Icons.check_box_outlined,
                                                color: greyColor)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Divider(height: 0.5, color: greyColor),
                                Row(
                                  children: [
                                    const Text("Priority : ",
                                        style: TextStyle(
                                            color: greyColor, fontSize: 13)),
                                    Text(list['pro_name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor,
                                            fontSize: 16)),
                                    const SizedBox(width: 10),
                                    Text("| ${list['create_date']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: greyColorSmall,
                                            fontSize: 12)),
                                    const Spacer(),
                                    TextInputUpdate(
                                        index: index,
                                        backvalue: (value) {
                                          setState(() {
                                            if (value == 'update') {
                                              getItems();
                                            }
                                          });
                                        },
                                        list: listModel),
                                    IconButton(
                                        color: redColor,
                                        onPressed: () {
                                          AwesomeDialog(
                                            width: 400,
                                            context: context,
                                            dialogType: DialogType.question,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: 'Do you want to delete?',
                                            // desc: "",

                                            btnOkOnPress: () async {
                                              await mydb.delelteIem(list['id']);
                                              await getItems();
                                            },
                                            btnCancelOnPress: () {},
                                            btnCancelColor: greyColorSmall,
                                            btnOkColor: greyColorSmall,
                                          ).show();
                                        },
                                        icon:
                                            const Icon(Icons.delete, size: 30)),
                                  ],
                                )
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
      ),
    );
  }

  int selectindex = -1;

  Widget typePrio(title, color, int i) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectindex = (selectindex == i) ? -1 : i;
                if (selectindex != -1) {
                  getById(i);
                  check = true;
                } else {
                  check = false;
                  getItems();
                }
              });
            },
            child: Container(
              height: 25,
              width: 25,
              color: color,
              child: (selectindex == i) ? const Icon(Icons.done) : null,
            ),
          ),
          const SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}
