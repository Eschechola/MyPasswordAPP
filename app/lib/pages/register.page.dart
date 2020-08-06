import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypassword/blocs/navigation.bloc.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassowrd.logo.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';

import 'login.page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: ListView(
          children: <Widget>[

            MyPasswordLogo(),

            MyPasswordInput(
              hintText: "Digite seu nome...",
            ),

            MyPasswordInput(
              hintText: "Digite seu email...",
            ),

            MyPasswordInput(
              hintText: "Digite sua senha...",
            ),

            MyPasswordInput(
              hintText: "Digite novamente sua senha...",
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: 28,
                bottom: 50
              ),
              
              child: Row(
                children: <Widget>[
                  Text(
                    "Já tem tem conta? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryColor
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      new NavigationBloc().pushReplacementTo(context, new LoginPage());
                    },
                    child: Text(
                      "Entre aqui",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 255, 255, 0.6)
                      ),
                    )
                  ),
                ],
              ),
            ),

            MyPasswordButton(
              inverseButton: false,
              function: (){},
              text: "Cadastre - se",
            ),
          ],
        )
      ),
    );
  }
}