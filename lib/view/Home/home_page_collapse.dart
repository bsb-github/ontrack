import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontrack/view/Home/Home.dart';
import 'package:ontrack/view/Home/plan.dart';
import 'package:ontrack/view/Home/progress.dart';

class HomePageCollapse extends StatefulWidget {
  const HomePageCollapse({Key? key}) : super(key: key);

  @override
  _HomePageCollapseState createState() => _HomePageCollapseState();
}

class _HomePageCollapseState extends State<HomePageCollapse> {
  int _selectedIndex = 0;

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return Plan();
      case 2:
        return Progress();
      default:
        return Home();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: const Color.fromARGB(255, 145, 145, 145),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: Scaffold(
        body: Center(
          child: _buildPage(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          items: <BottomNavigationBarItem>[
            _buildBottomNavigationBarItem(Icons.home, 'Home'),
            _buildBottomNavigationBarItem(Icons.calendar_today, 'Plan'),
            _buildBottomNavigationBarItem(Icons.bar_chart, 'Progress'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
