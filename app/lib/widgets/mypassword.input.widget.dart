import 'package:flutter/material.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordInput extends StatelessWidget {
  TextEditingController controller;
  String hintText = "";
  TextInputType keyboardType;
  bool isPassword = false;
  List<ErrorsValidation> errors;
  Function onChanged = (String arg){};

  MyPasswordInput({@required this.hintText, @required this.keyboardType, this.controller, this.isPassword = false, this.errors, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
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
        )),

        Padding(
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 30,
            right: 20
          ),
          child: 
          this.errors != null && this.errors.length > 0 
          ? Container(
            width: MediaQuery.of(context).size.width,
            child:
              Text(
              this.errors[0].error,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: 17
              ),
            )
          )
          : Padding(
            padding: EdgeInsets.all(10)
          )
        )
      ],
    ); 
  }
}
