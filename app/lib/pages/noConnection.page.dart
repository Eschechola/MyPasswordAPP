import 'package:flutter/material.dart';
import 'package:mypassword/pages/index.page.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void pushIndexPage(){
      new NavigationBloc().popAllAndReplace(context, new IndexPage(), false);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: MediaQuery.of(context).size.height * 0.15
              ),
              child: Image(
                image: AssetImage('assets/images/lost-connection.png'),
              )
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 25,
                right: 25,
                bottom: 20
              ),
              child: Text(
                "Opa! Parece que você está sem conexão com a internet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 25,
                ),
              )
            ),


            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 25,
                right: 25
              ),

              child: MyPasswordButton(
                text: "Tentar Novamente",
                inverseButton: false,
                function: pushIndexPage,
              )
            )
          ],
        )
      ),
    );
  }
}