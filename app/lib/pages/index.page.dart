import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypassword/blocs/bloc/navigation.service.dart';
import 'package:mypassword/pages/welcome.page.dart';
import 'package:mypassword/styles/app.colors.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State with SingleTickerProviderStateMixin {

  AnimationController rotationController;

  void pushHomePage(){
    Timer(Duration(seconds: 5), (){
      NavigationBloc().pushReplacementTo(context, new WelcomePage());
    });
  } 

  void initState() {
    super.initState();

    //inicia a animação do loading na tela inicial
    rotationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );

    rotationController.repeat();

    //esconde a UI overlay e chama a função para carregar a Home
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryColor, // navigation bar color
      statusBarColor: AppColors.primaryColor, // status bar color
    ));

    pushHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),

        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Column(
              children: <Widget>[
                Text(
                  "MyPassword",
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.1
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: rotationController,
                    child: Icon(
                      Icons.vpn_key,
                      color: AppColors.secondaryColor,
                      size: 40,
                    ),

                    builder: (BuildContext context, Widget _widget) {
                      return Transform.rotate(
                        angle: rotationController.value * 6.2,
                        child: _widget,
                      );
                    },
                  ),
                )
              ],
            ),
          ) 
        )
      ),
    );
  }
}