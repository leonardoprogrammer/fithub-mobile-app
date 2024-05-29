import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      body: Center(
        child: Text(
          'Não há dados para mostrar.',
          style: TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.center
        ),
      ),
    );
  }
}