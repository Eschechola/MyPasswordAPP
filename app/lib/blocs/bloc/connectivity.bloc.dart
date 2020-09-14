import 'dart:io';

import 'package:mypassword/blocs/bloc/base.bloc.dart';

class ConnectivityBloc extends BaseBloc{
  Future<bool> userHaveInternetConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;

      else
        return false;

    } on SocketException catch (_) {
      return false;
    }
  }
}