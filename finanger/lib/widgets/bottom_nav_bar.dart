import 'package:flutter/material.dart';

import '../screens/main screens/home_screen.dart';
import '../screens/main screens/stat_screen.dart';
import '../screens/main screens/transaction_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  Widget buildBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const StatScreen();
      case 2:
        return const TransactionScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.greenAccent.shade100,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz_sharp), label: 'Transaction'),
        ],
      ),
    );
  }
}
