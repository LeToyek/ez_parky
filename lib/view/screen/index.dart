import 'package:ez_parky/repository/provider/bottom_nav_bar_provider.dart';
import 'package:ez_parky/view/screen/main/scanner_screen.dart';
import 'package:ez_parky/view/screen/main/setting_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexScreen extends ConsumerWidget {
  const IndexScreen({super.key});
  static const String routePath = '/';
  static const String routeName = 'index';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(bottomNavProvider);
    final navigationNotifier = ref.read(bottomNavProvider.notifier);
    return Scaffold(
        body: _buildPageContent(navigationState),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.qr_code_2_outlined),
            onPressed: () => {navigationNotifier.setValueToDB(2)}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNavBar(navigationState));
  }

  Widget _buildBottomNavBar(int selectedIndex) {
    return Consumer(builder: (context, ref, _) {
      final navigationNotifier = ref.read(bottomNavProvider.notifier);
      return Card(
        margin: const EdgeInsets.only(top: 1, right: 4, left: 4),
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.shadow,
        color: Theme.of(context).colorScheme.surfaceVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) => navigationNotifier.setValueToDB(index),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history_edu_outlined),
              activeIcon: Icon(Icons.history_edu),
              label: "History",
            ),
            selectedIndex == 3
                ? const BottomNavigationBarItem(
                    icon: Icon(Icons.qr_code_2_outlined,
                        color: Colors.transparent),
                    label: "")
                : const BottomNavigationBarItem(
                    icon: Icon(Icons.abc, color: Colors.transparent),
                    label: ""),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: "Settings",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person),
              label: "Account",
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const ScannerScreen();
      case 1:
        return const SettingScreen();
      case 2:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
