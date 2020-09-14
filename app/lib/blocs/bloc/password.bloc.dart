import 'dart:convert';

import 'package:mypassword/blocs/bloc/base.bloc.dart';
import 'package:mypassword/blocs/service/password.service.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/settings/settings.dart';

class PasswordBloc extends BaseBloc{
  Customer _customer;

  Future _getCustomer() async{
    _customer = await getCustomerSession();
  }

  Future<ResponseModel> getAllPasswords(int id) async{
    try{
      dynamic apiResponse;
      await _getCustomer();

      await new PasswordService().getAllPasswords(id, _customer.token).then((response) =>{
        apiResponse = json.decode(response.body),
      });

      return await super.valitadeResponse(apiResponse);
    }
    catch(Exception){
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);
    }
  }

  Future<ResponseModel> insertPassword(Password password) async{
    try{
      dynamic apiResponse;
      await _getCustomer();

      await new PasswordService().insertPassword(password, _customer.token).then((response) => {
        apiResponse = json.decode(response.body),
      });

      return await super.valitadeResponse(apiResponse);
    }
    catch(Exception){
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);
    }
  }

  Future<ResponseModel> deletePassword(int id) async{
    // try{
      dynamic apiResponse;
      await _getCustomer();

      await new PasswordService().deletePassword(id, _customer.token).then((response) => {
        apiResponse = json.decode(response.body)
      });

      return await super.valitadeResponse(apiResponse);
    // }
    // catch(Exception e){
    //   return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);
    // }
  }
}