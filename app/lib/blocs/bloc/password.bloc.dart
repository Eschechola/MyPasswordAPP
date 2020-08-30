import 'dart:convert';

import 'package:mypassword/blocs/service/password.service.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/settings/settings.dart';

class PasswordBloc{

  Future<ResponseModel> getAllPasswords(int id, String token) async{
    dynamic apiResponse;

    await new PasswordService().getAllPasswords(id, token).then((response) =>{
      apiResponse = json.decode(response.body),
    });

    if(apiResponse == null)
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

    ResponseModel responseModel = new ResponseModel().convertApiResponseToResponseModel(apiResponse);

    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);

    return responseModel;
  }
}