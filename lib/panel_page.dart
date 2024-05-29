import 'package:flutter/material.dart';

import 'package:fithub/dashboard_page.dart';
import 'package:fithub/history_page.dart';
import 'package:fithub/profile_page.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  _PanelPageState createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  int _selectedIndex = 0;

  final _pages = [
    const DashboardPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1D1D1D),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF00A2FF),
        onTap: _onItemTapped,
      ),
    );
  }
}
