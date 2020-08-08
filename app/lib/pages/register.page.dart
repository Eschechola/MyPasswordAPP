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

    void pushLoginPage(){
      NavigationBloc().pushReplacementTo(context, LoginPage());
    }

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
              keyboardType: TextInputType.text,
            ),

            MyPasswordInput(
              hintText: "Digite seu email...",
              keyboardType: TextInputType.emailAddress,
            ),

            MyPasswordInput(
              hintText: "Digite sua senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
            ),

            MyPasswordInput(
              hintText: "Digite novamente sua senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
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
                    onTap: pushLoginPage,
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