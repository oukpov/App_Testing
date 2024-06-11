import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/List_Local.dart';
import 'package:smaill_project/future/pages/Menu/Table.dart';
import 'package:smaill_project/future/pages/Menu/graph/Graph_page.dart';
import 'package:smaill_project/integration/widget_keys.dart';
import 'Menu/Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> tabs = const [HomePage(), TableScreen(), GraphPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: iconblue,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: buttonNavigatoin,
        iconSize: 25,
        items: [
          for (int i = 0; i < listIConButtonBar.length; i++)
            BottomNavigationBarItem(
              icon: Icon(
                listIConButtonBar[i],
                color: (currentIndex == i) ? iconblue : greyColor,
              ),
              label: listTitleButtonBar[i]['title'],
              backgroundColor: greyColor,
            ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
