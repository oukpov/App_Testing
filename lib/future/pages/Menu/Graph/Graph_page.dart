import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/date_Dropdown.dart';
import 'package:smaill_project/future/data/MyDB.dart';
import 'package:smaill_project/future/pages/Menu/Graph/cando.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<Map> listModel = [];
  List<Map> listItems = [];
  List<Map> listnone = [];
  List<Map> listhight = [];
  List<Map> listmidle = [];
  List<Map> listlow = [];

  MyDB mydb = MyDB();
  Future<void> getItems() async {
    await mydb.createUser();
    listItems = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    setState(() {
      listModel = listItems;
    });
    listnone = await itemWhere('0', listModel);
    listhight = await itemWhere('1', listModel);
    listmidle = await itemWhere('2', listModel);
    listlow = await itemWhere('3', listModel);
  }

  Future<List<Map>> itemWhere(String proID, List<Map> list) async {
    List<Map> result = list.where((property) {
      final item = property['pro_id'].toString().toLowerCase();
      final lowerCaseQuery = proID.toLowerCase();
      return item.contains(lowerCaseQuery);
    }).toList();
    return result;
  }

  final colorList = <Color>[
    noneColor,
    hightColor,
    midleColor,
    lowColor,
  ];
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

  bool checks = false;
  bool search = false;
  final start = TextEditingController();
  final end = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Row(
          children: [
            startDateDrop,
            const SizedBox(width: 10),
            endDateDrop,
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                search = false;
                searchbyDate("");
              },
              child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: iconblue,
                    border: Border.all(width: 0.5, color: greyColor),
                  ),
                  child: const Icon(Icons.search, color: whileColor)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          checks = !checks;
                          if (checks) {
                            searchbyDate('1');
                          } else {
                            searchbyDate('0');
                          }
                        });
                      },
                      icon: checks
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank,
                              color: greyColor)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getItems();
                          endDateDrop.clear();
                          startDateDrop.clear();
                          search = true;
                        });
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: greyColor,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(height: 10),
              PieChart(
                dataMap: {
                  "None": double.parse(listnone.length.toString()),
                  "Hight": double.parse(listhight.length.toString()),
                  "Midle": double.parse(listmidle.length.toString()),
                  "Low": double.parse(listlow.length.toString()),
                },
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "GraphPage",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  // legendShape: _BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
              const SizedBox(height: 20),
              CandoCase(
                none: listnone,
                hight: listhight,
                midle: listmidle,
                low: listlow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchbyDate(String query) async {
    listItems = await mydb.db.rawQuery('SELECT * FROM list_To_do_Table');
    final lowerCaseQuery = query.toLowerCase();
    List<Map> searchedItems = listItems.where((property) {
      final checks = property['checks'].toString().toLowerCase();

      return checks.contains(lowerCaseQuery);

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
      listnone = await itemWhere('0', listModel);
      listhight = await itemWhere('1', listModel);
      listmidle = await itemWhere('2', listModel);
      listlow = await itemWhere('3', listModel);
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
    listnone = await itemWhere('0', listModel);
    listhight = await itemWhere('1', listModel);
    listmidle = await itemWhere('2', listModel);
    listlow = await itemWhere('3', listModel);
  }
}
