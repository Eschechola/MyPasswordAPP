import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypassword/blocs/navigation.bloc.dart';
import 'package:mypassword/main.dart';
import 'package:mypassword/pages/register.page.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassowrd.logo.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool remember = true;

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

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1
              ),
              child: Column(
                children: <Widget>[
                  MyPasswordInput(
                    hintText: "Digite seu nome...",
                  ),

                  MyPasswordInput(
                    hintText: "Digite seu email...",
                  ),
                  
                  CheckboxListTile(
                    title: Text(
                      "Lembrar de mim",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18
                      ),
                    ),
                    activeColor: AppColors.thirdColor,
                    checkColor: AppColors.secondaryColor,
                    value: remember,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading
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
                          "Ainda não tem uma conta? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.secondaryColor
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            new NavigationBloc().pushReplacementTo(context, new RegisterPage());
                          },
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.6)
                            ),
                          )
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08
                    ),
                    child: MyPasswordButton(
                      text: "Entrar",
                      function: (){},
                      inverseButton: false
                    )
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}