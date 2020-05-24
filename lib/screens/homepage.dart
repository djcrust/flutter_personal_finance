import 'package:flutter/material.dart';
import 'package:my_money_management_app/screens/budgetlist.dart';
import 'package:my_money_management_app/screens/categorylist.dart';
import 'package:my_money_management_app/screens/expense_list.dart';
import 'package:my_money_management_app/screens/overview.dart';
import 'package:my_money_management_app/widget/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _pageOptions = [
    OverviewPage(),
    BudgetPage(),
    CategoryPage(),
    ExpensePage()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showSelectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            title: Text('Overview'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text('Budget'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Expenses'),
            backgroundColor: Colors.red,
          ),
        ],
      ),
      drawer: buildDrawer(context),
    );
  }
}
