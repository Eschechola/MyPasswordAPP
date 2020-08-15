import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.appBar.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';
import 'package:mypassword/widgets/mypassword.navmenu.dart';

class ManagePasswordPage extends StatefulWidget {
  @override
  _ManagePasswordPage createState() =>_ManagePasswordPage();
}

class _ManagePasswordPage extends State<ManagePasswordPage> {
  bool acceptedTerms = true;

  void savePassword(){

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: MyPasswordAppBar(
        title: "Criar Nova Senha"
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 90),
              child: Text(
                "Preencha os campos a seguir para criar uma nova senha",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 25
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30),
            ),

            MyPasswordInput(
              hintText: "Digite de onde é a senha...",
              keyboardType: TextInputType.text,
            ),

            MyPasswordInput(
              hintText: "Digite a senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
            ),

            CheckboxListTile(
              title: Row(children: <Widget>[
                    Text(
                      "Concordo com os ",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18
                      ),
                    ),

                    Text(
                      "TERMOS DE USO",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                activeColor: AppColors.thirdColor,
                checkColor: AppColors.secondaryColor,
                value: acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    acceptedTerms = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading
              ),

              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.07),
              ),

              MyPasswordButton(
                function: savePassword,
                inverseButton: false,
                text: "Salvar",
              )
          ],
        )
      ),
    );
  }
}