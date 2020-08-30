import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:mypassword/blocs/service/customer.service.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/settings/settings.dart';

class CustomerBloc {

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

  Future<Customer> getCustomerSession() async {
    var customer = new Customer(
      id: await _session.get("id"),
      name: await _session.get("name"),
      email: await _session.get("email"),
      token: await _session.get("token"),
      tokenExpireDate: await _session.get("tokenExpireDate")
    );
    
    return customer;
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

    ResponseModel responseModel = new ResponseModel().convertApiResponseToResponseModel(apiResponse);

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

    ResponseModel responseModel = new ResponseModel().convertApiResponseToResponseModel(apiResponse);

    //erro caso o login não seja realizado
    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);

    //cria a sessão do usuário
    var customer = new Customer(
      id: responseModel.data["id"],
      name: responseModel.data["name"],
      email: loginCustomer.email,
      token: responseModel.data["token"],
      tokenExpireDate: responseModel.data["tokenExpireDate"]
    );

    await _createCustomerSession(customer);
    
    return responseModel;
  }
}