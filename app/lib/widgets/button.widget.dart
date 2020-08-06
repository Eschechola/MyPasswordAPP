import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordButton extends StatelessWidget {
  var text = "";
  Function function;

  MyPasswordButton({@required this.text, @required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(60)),
        child: FlatButton(
            onPressed: function,
            child: Text(text,
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontFamily: "Arial"))),
      ),
    );
  }
}
