import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordCard extends StatelessWidget {
  Widget child;
  double height;
  Function onTap;

  MyPasswordCard({this.child = null, this.height = null, this.onTap = null });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 30),
        child: InkWell(
          onTap: this.onTap,
          child: Container(
            height: this.height != null ? height : MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: this.child
          ) 
        )
    );
  }
}
