// import 'package:flutter/material.dart';
// import 'package:smaill_project/future/component/Colors.dart';
// import 'package:smaill_project/future/component/input_TextUpdate.dart';
// import 'package:smaill_project/future/data/MyDB.dart';
// import 'package:smaill_project/integration/widget_keys.dart';

// class ListAll extends StatefulWidget {
//   ListAll({super.key, required this.listModel});
//   late List<Map> listModel;

//   @override
//   State<ListAll> createState() => _ListAllState();
// }

// class _ListAllState extends State<ListAll> {
//   List<Map> listItems = [];
//   Future<void> getItems() async {
//     await mydb.createUser();
//     listItems = await mydb.db.rawQuery('SELECT * FROM ItemList4');
//     if (listItems.isNotEmpty) {
//       setState(() {
//         widget.listModel = listItems;
//       });
//       for (int i = 0; i < widget.listModel.length; i++) {
//         await mydb.db.rawInsert(
//             "INSERT INTO ItemList4(items, checks) VALUES (?,?);",
//             [widget.listModel[i]['items'].toString(), 0]);
//       }

//       print('========> ${widget.listModel.length}');
//     }
//   }

//   List<Map> listModel = [];
//   MyDB mydb = MyDB();
//   @override
//   void initState() {
//     listModel = widget.listModel;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView.builder(
//         key: WidgetKeys.listView,
//         itemCount: listModel.length,
//         itemBuilder: (context, index) {
//           var list = listModel[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Card(
//               elevation: 10,
//               child: Container(
//                 height: 60,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: (list['checks'] == 1) ? greyColorSmall : whileColor,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Text(index.toString(),
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: (list['checks'] == 0)
//                                   ? greyColor
//                                   : whileColor,
//                               fontSize: 17)),
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               if (list['checks'] == 0) {
//                                 mydb.done(list['id'], 1);
//                               } else {
//                                 mydb.done(list['id'], 0);
//                               }
//                               getItems();
//                             });
//                           },
//                           icon: (list['checks'] == 0)
//                               ? const Icon(Icons.check_box_outline_blank,
//                                   color: greyColorSmall)
//                               : const Icon(Icons.check_box, color: whileColor)),
//                       Text(
//                         list['items'].toString(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color:
//                                 (list['checks'] == 1) ? whileColor : greyColor),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                           color: greenColor,
//                           onPressed: () async {
//                             showUpdate(index, listModel);
//                           },
//                           icon: const Icon(Icons.edit, size: 30)),
//                       IconButton(
//                           color: redColor,
//                           onPressed: () async {
//                             await mydb.delelteIem(list['id']);
//                             await getItems();
//                           },
//                           icon: const Icon(Icons.delete, size: 30)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future showUpdate(int index, List list) {
//     return showDialog(
//         context: context,
//         builder: (context) => Center(
//             child: AlertDialog(
//                 backgroundColor: whileColor,
//                 title: Text('No.$index',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 17)),
//                 content: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: whileColor),
//                   height: 60,
//                   width: double.infinity,
//                   child: TextInputUpdate(
//                     index: index,
//                     list: list,
//                     label: 'Update Item',
//                     backvalue: (value) {
//                       setState(() {
//                         if (value != '' || value != null) {
//                           listModel = value;
//                         }
//                       });
//                     },
//                   ),
//                 ))));
//   }
// }
