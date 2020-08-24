import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:mypassword/blocs/service/customer.service.dart';
import 'package:mypassword/blocs/service/apiResponse.model.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/settings/settings.dart';

class CustomerBloc {

  FlutterSession session;

  CustomerBloc(){
    session = new FlutterSession(); 
  }

  ResponseModel _convertApiResponseToResponseModel(dynamic response){
    return new ResponseModel(
      message: response['message'],
      success: response['success'],
      data: response['data']
    );
  }

  Future _createCustomerSession(Customer customer) async {
    await session.set("name", customer.name);
    await session.set("email", customer.email);
    await session.set("token", customer.token);
    await session.set("tokenExpireDate", customer.tokenExpireDate.toString());
  }

  void _showCustomerSession() async{
    print(await session.get("name"));
    print(await session.get("email"));
    print(await session.get("token"));
    print(await session.get("tokenExpireDate"));
  }

  Future<Customer> getCustomerSession() async {
    return new Customer(
      name: await session.get("name"),
      email: await session.get("email"),
      token: await session.get("token"),
      tokenExpireDate: await session.get("tokenExpireDate")
    );
  }

  Future<ResponseModel> insertCustomer(Customer customer) async {
    dynamic apiResponse;
    
    //insere o usuário no banco de dados WEB
    await new CustomerService().insertCustomer(customer).then((response) =>{
      apiResponse = json.decode(response.body)
      }
    );

    //erro caso a rota não seja encontrada
    if(apiResponse == null)
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

    ResponseModel responseModel = _convertApiResponseToResponseModel(apiResponse);

    //erro caso o cliente não seja inserido
    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);

    //cria a sessão do usuário
    customer.token = responseModel.data["token"]["token"];
    customer.tokenExpireDate = responseModel.data["token"]["tokenExpires"];
    await _createCustomerSession(customer);

    return responseModel;
  }

  Future<ResponseModel> loginCustomer(Login loginCustomer) async{
    dynamic apiResponse;

    //loga o usuário no banco de dados WEB
    await new CustomerService().loginCustomer(loginCustomer).then((response) =>{
      apiResponse = json.decode(response.body),
    });

    //erro caso a rota não seja encontrada
    if(apiResponse == null)
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

    ResponseModel responseModel = _convertApiResponseToResponseModel(apiResponse);

    //erro caso o login não seja realizado
    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);

    //cria a sessão do usuário
    var customer = new Customer(
      name: responseModel.data["name"],
      email: loginCustomer.email,
      token: responseModel.data["token"],
      tokenExpireDate: responseModel.data["tokenExpires"]
    );

    await _createCustomerSession(customer);
    
    return responseModel;
  }
}