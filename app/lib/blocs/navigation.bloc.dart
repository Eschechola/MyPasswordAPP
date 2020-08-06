import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBloc{
  
  void pushTo(BuildContext context, Widget widgetPage){
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => widgetPage,
      ));
  }

  void pushReplacementTo(BuildContext context, Widget widgetPage){
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context) => widgetPage,
      ));
  }
}