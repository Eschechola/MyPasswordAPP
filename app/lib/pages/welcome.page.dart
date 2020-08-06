import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/button.widget.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            color: AppColors.secondaryColor,
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
                        function: (){},
                      ),
                      
                      MyPasswordButton(
                        text: "Cadastro",
                        function: (){},
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