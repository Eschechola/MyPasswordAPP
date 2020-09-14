import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/base.bloc.dart';
import 'package:mypassword/blocs/bloc/connectivity.bloc.dart';
import 'package:mypassword/pages/noConnection.page.dart';

class NavigationBloc extends BaseBloc{
  
  void _pushToNoConnectionPage(BuildContext context) async{ 
    pushTo(context, new NoConnectionPage(), false);
  }

  void pushTo(BuildContext context, Widget widgetPage, [bool needInternetConnection = true]) async{
    if(needInternetConnection){
      var haveConnection = await new ConnectivityBloc().userHaveInternetConnection();

      if(!haveConnection){
        _pushToNoConnectionPage(context);
        return;
      }
    }
    
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => widgetPage,
      ));
  }

  void pushReplacementTo(BuildContext context, Widget widgetPage, [bool needInternetConnection = true]) async{
    if(needInternetConnection){
      var haveConnection = await new ConnectivityBloc().userHaveInternetConnection();

      if(!haveConnection){
        _pushToNoConnectionPage(context);
        return;
      }
    }
    
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context) => widgetPage,
      ));
  }

  void pop(BuildContext context, [bool needInternetConnection = true]) async {
    if(needInternetConnection){
      var haveConnection = await new ConnectivityBloc().userHaveInternetConnection();

      if(!haveConnection){
        _pushToNoConnectionPage(context);
        return;
      }
    }

    Navigator.of(context).pop(context);
  }


  void popAllAndReplace(BuildContext context, Widget widgetPage, [bool needInternetConnection = true]) async {
    if(needInternetConnection){
      var haveConnection = await new ConnectivityBloc().userHaveInternetConnection();

      if(!haveConnection){
        _pushToNoConnectionPage(context);
        return;
      }
    }

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) => widgetPage), (Route<dynamic> route) => false);
  }
}