import 'package:flutter/material.dart';

class BottomNavDestinations {
  final List<NavigationDestination> navs = [
    NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.menu),
      icon: Icon(Icons.menu_rounded),
      label: 'Feeds',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.messenger_sharp),
      icon: Icon(Icons.messenger_outline_sharp),
      label: 'Rooms',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.settings),
      icon: Icon(Icons.settings_outlined),
      label: 'Setting',
    ),
  ];
}
