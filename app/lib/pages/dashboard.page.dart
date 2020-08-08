import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.navmenu.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: AppBar(
        title: Text(
          "MyPassword",
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
      ),
    );
  }
}