import 'package:flutter/material.dart';

class buildNavigationBar extends StatefulWidget {
  int _selectedIndex;

  buildNavigationBar(this._selectedIndex);

  @override
  _buildNavigationBarState createState() => _buildNavigationBarState();
}

class _buildNavigationBarState extends State<buildNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget._selectedIndex,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: Colors.black45,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          widget._selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          title: Text('Accounts'),
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('Categories'),
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Transaction'),
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          title: Text('Overview'),
          backgroundColor: Colors.red,
        ),
      ],
    );
  }
}


