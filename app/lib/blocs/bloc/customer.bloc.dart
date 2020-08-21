import 'dart:convert';

import 'package:mypassword/blocs/repository/customer.respository.dart';
import 'package:mypassword/blocs/service/customer.service.dart';
import 'package:mypassword/blocs/service/apiResponse.model.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/settings/settings.dart';

class CustomerBloc {

  Future<ResponseModel> registerCustomer(Customer customer) async {
    dynamic apiResponse = null;
    
    //insere o usuário no banco de dados WEB
    await new CustomerService().registerCustomer(customer).then((response) =>{
      apiResponse = json.decode(response.body)
      }
    );

    //erro caso a rota não seja encontrada
    if(apiResponse == null)
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

    ResponseModel responseModel = new ResponseModel(
      message: apiResponse['message'],
      success: apiResponse['success'],
      data: apiResponse['data']
    );

    //erro caso o cliente não seja inserido
    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);
    
    //insere o usuário no banco de dados local
    await new CustomerRepository().registerCustomer(customer).then((response) => {
      if(!response)
        responseModel = new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null)
    });

    return responseModel;
  }
}