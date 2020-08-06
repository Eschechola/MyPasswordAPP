import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: Column(
          children: <Widget>[
            Text(
              "MyPassword",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.vpn_key,
                color: AppColors.secondaryColor,
                size: 40,
              ),
            ),
          ],
        ));
  }
}
