import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordButton extends StatelessWidget {
  var text = "";
  var inverseButton = false;
  Function function;

  MyPasswordButton({@required this.text, @required this.function, @required this.inverseButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.9,
        height: 50,
        decoration: BoxDecoration(
            color: inverseButton ? Colors.transparent : AppColors.thirdColor,//AppColors.thirdColor,
            borderRadius: BorderRadius.circular(60)),
        child: FlatButton(
            onPressed: function,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
              side: BorderSide(
                color: inverseButton ? AppColors.secondaryColor : AppColors.thirdColor,
                width: 1,
                style: BorderStyle.solid,
              )
            ),
            child: Text(text,
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontFamily: "Arial"))),
      ),
    );
  }
}
