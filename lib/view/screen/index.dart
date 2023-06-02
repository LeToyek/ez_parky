import 'package:ez_parky/view/screen/main/home_screen.dart';
import 'package:ez_parky/view/screen/main/park_screen.dart';
import 'package:ez_parky/view/screen/main/profile_screen.dart';
import 'package:ez_parky/view/screen/main/setting_screen.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});
  static const String routePath = '/';
  static const String routeName = 'index';

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 0;
  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Parking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavItemSelected,
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ParkScreen();
      case 2:
        return const SettingScreen();
      case 3:
        return const EzProfileScreen();
      default:
        return Container();
    }
  }
}
