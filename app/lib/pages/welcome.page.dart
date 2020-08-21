import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/navigation.service.dart';
import 'package:mypassword/pages/login.page.dart';
import 'package:mypassword/pages/register.page.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    void pushLoginPage(){
      NavigationBloc().pushTo(context, LoginPage());
    }

    void pushRegisterPage(){
      NavigationBloc().pushTo(context, RegisterPage());
    }


    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppColors.primaryColor
            ),

            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 90,
                          bottom: 70
                        ),
                        child: Text(
                          "Todas as suas senhas protegidas em qualquer lugar.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            fontSize: MediaQuery.of(context).size.width * 0.06
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/home-bg.png'),
                      )
                    ],
                  )
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
                      ),

                      MyPasswordButton(
                        text: "Login",
                        function: pushLoginPage,
                        inverseButton: true,
                      ),
                      
                      MyPasswordButton(
                        text: "Cadastro",
                        function: pushRegisterPage,
                        inverseButton: false,
                      )                      //Padding()
                    ],
                  ) ,
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}