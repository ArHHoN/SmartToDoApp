import 'package:flutter/material.dart';
import 'package:smart_todoapp/index_page.dart';
import 'package:smart_todoapp/login_page.dart';
import 'package:smart_todoapp/services/app_session.dart';
import 'package:smart_todoapp/to_do_app_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


    class _HomeScreenState extends State<HomePage> {
  int _selectedIndex = 0;
  AppSession session = AppSession();

  List<Widget> get _pages {
    return [
      IndexPage(),
      ToDoAppPage(),

    ];
  }

  List<BottomNavigationBarItem> get _navItems {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: "Index",
      ),
        const BottomNavigationBarItem(
        icon: Icon(Icons.sunny),
        label: "ToDoApp",
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages;
    final navItems = _navItems;

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: navItems,
      ),
    );
  }
}
