import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/styles/app.colors.dart';

class MyPasswordAlertDialog {
  String title = "";
  String message = "";
  BuildContext context;
  List<Widget> actions = null;

  MyPasswordAlertDialog(String title, String message, BuildContext context, List<Widget> actions){
    this.context = context;
    this.title = title;
    this.message = message;
    
    if(actions != null)
      this.actions = actions;
    
    else
      actions.add(
        FlatButton(
          onPressed: (){
            NavigationBloc().pop(context);
          },
          child: Text("Ok"),
        ));
  }

  Future<void> showModalDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.only(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 23,
              color: AppColors.thirdColor
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 23,
                    color: AppColors.thirdColor
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ...actions
          ],
        );
      },
    );
  }
}