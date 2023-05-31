import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var ezDrawer = Drawer(
  child: ListView(
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Text(
          'Drawer Header',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
      ListTile(
        title: const Text('Menu 1'),
        onTap: () {
          // Aksi ketika menu 1 diklik
        },
      ),
      ListTile(
        title: const Text('Menu 2'),
        onTap: () {
          // Aksi ketika menu 2 diklik
        },
      ),
      ListTile(
        title: const Text('Logout'),
        onTap: () async {
          // Aksi ketika menu 3 diklik
          await FirebaseAuth.instance.signOut();
        },
      ),
    ],
  ),
);
