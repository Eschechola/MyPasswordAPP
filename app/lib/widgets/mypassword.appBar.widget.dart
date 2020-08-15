import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";

  MyPasswordAppBar({@required this.title});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
