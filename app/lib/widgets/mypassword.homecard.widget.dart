import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/styles/app.colors.dart';

import 'mypassword.card.widget.dart';

class MyPasswordHomeCard extends StatelessWidget {

  String username = "";
  bool isLoading = true;

  MyPasswordHomeCard({@required this.username, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return MyPasswordCard(
              child: isLoading ? 
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.cardText,
                ),
              ) 
              : Row(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(
                       left: 20,
                       right: 20
                     ),
                     child: Container(
                      width: 90,
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(80)
                      ),
                      child: Container(
                        width: 87,
                        height: 87,
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(87)
                        ),
                      ), 
                    ), 
                   ),

                   Expanded(
                      child: Text(
                        "Olá ${this.username},\nseja bem - vindo!",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                 ],
              ),
            );
  }
}