import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.card.widget.dart';
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
        child: ListView(
          children: <Widget>[
            MyPasswordCard(
               child: Row(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(
                       left: 20,
                       right: 20
                     ),
                     child: Container(
                      width: 90,
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(80)
                      ),
                      child: Container(
                        width: 87,
                        height: 87,
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(87)
                        ),
                      ), 
                    ), 
                   ),

                   Expanded(
                      child: Text(
                        "Olá usuário,\nseja bem - vindo!",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                 ],
              )
            )
          ],
        ),
      ),
    );
  }
}