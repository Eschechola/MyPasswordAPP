import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordNoPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 50
            ),
            child: Image(
              height: MediaQuery.of(context).size.height * 0.19,
              image: AssetImage('assets/images/no-password-icon.png'),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20
            ),
            child: Text(
              "Você ainda não tem nenhuma senha cadastrada, crie uma!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.cardText,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}