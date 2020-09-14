import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:mypassword/blocs/bloc/base.bloc.dart';
import 'package:mypassword/blocs/service/customer.service.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/settings/settings.dart';

class CustomerBloc extends BaseBloc{

  FlutterSession _session;

  CustomerBloc(){
    _session = new FlutterSession(); 
  }

  Future _createCustomerSession(Customer customer) async {
    await _session.set("id", customer.id.toString());
    await _session.set("name", customer.name);
    await _session.set("email", customer.email);
    await _session.set("token", customer.token);
    await _session.set("tokenExpireDate", customer.tokenExpireDate.toString());
  }

  void _showCustomerSession() async{
    print(await _session.get("name"));
    print(await _session.get("email"));
    print(await _session.get("token"));
    print(await _session.get("tokenExpireDate"));
  }

  Future<ResponseModel> insertCustomer(Customer customer) async {
    try{
      dynamic apiResponse;
      
      //insere o usuário no banco de dados WEB
      await new CustomerService().insertCustomer(customer).then((response) =>{
        apiResponse = json.decode(response.body)
        }
      );

      var response = await super.valitadeResponse(apiResponse);

      if(response.success)
        //cria a sessão do usuário
        customer.token = response.data["token"]["token"];
        customer.tokenExpireDate = response.data["token"]["tokenExpires"];
        await _createCustomerSession(customer);

      return response;
    }
    catch(Exception){
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);
    }  
  }

  Future<ResponseModel> loginCustomer(Login loginCustomer) async{
    try{
       dynamic apiResponse;

      //loga o usuário no banco de dados WEB
      await new CustomerService().loginCustomer(loginCustomer).then((response) =>{
        apiResponse = json.decode(response.body),
      });

     var response = await super.valitadeResponse(apiResponse);

      if(response.success){
        //cria a sessão do usuário
        var customer = new Customer(
          id: response.data["id"],
          name: response.data["name"],
          email: loginCustomer.email,
          token: response.data["token"],
          tokenExpireDate: response.data["tokenExpireDate"]
        );

        await _createCustomerSession(customer);
      }
        
      return response;
    }
    catch(Exception){
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);
    }
  }
}