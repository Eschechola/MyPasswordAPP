import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordInput extends StatelessWidget {
  var hintText = "";

  MyPasswordInput({@required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: BorderSide(color: AppColors.thirdColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide:
                  BorderSide(color: AppColors.secondaryColor, width: 1.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              fontFamily: "Arial",
              fontSize: 18,
            ),
          ),
        ));
  }
}
