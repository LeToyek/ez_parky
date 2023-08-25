import 'package:ez_parky/view/screen/main/home_screen.dart';
import 'package:ez_parky/view/screen/main/scanner_screen.dart';
import 'package:ez_parky/view/screen/main/setting_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
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
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: _buildPageContent(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorTheme.primary,
        unselectedItemColor: colorTheme.onBackground,
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
        return const ScannerScreen();
      case 2:
        return const SettingScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
