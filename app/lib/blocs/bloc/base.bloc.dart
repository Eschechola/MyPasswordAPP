import 'package:flutter_session/flutter_session.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/settings/settings.dart';

class BaseBloc{
  FlutterSession _session;

  BaseBloc(){
    _session = new FlutterSession();
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

  Future<ResponseModel> valitadeResponse(dynamic response) async {
    if(response == null)
        return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

      ResponseModel responseModel = new ResponseModel().convertApiResponseToResponseModel(response);

      if(!responseModel.success)
        return new ResponseModel(message: responseModel.message, success: false, data: null);

      return responseModel;
  }
}