import 'dart:convert';

import 'package:mypassword/blocs/service/password.service.dart';
import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/models/entities/response.model.dart';
import 'package:mypassword/settings/settings.dart';

class PasswordBloc{

  String _token;

  PasswordBloc(String token){
    _token = token;
  }

  Future<ResponseModel> getAllPasswords(int id) async{
    dynamic apiResponse;

    await new PasswordService().getAllPasswords(id, _token).then((response) =>{
      apiResponse = json.decode(response.body),
    });

    if(apiResponse == null)
      return new ResponseModel(message: Settings.ERROR_API_MESSAGE, success: false, data: null);

    ResponseModel responseModel = new ResponseModel().convertApiResponseToResponseModel(apiResponse);

    if(!responseModel.success)
      return new ResponseModel(message: responseModel.message, success: false, data: null);

    return responseModel;
  }

  Future<ResponseModel> insertPassword(Password password) async{
    dynamic apiResponse;

    await new PasswordService().insertPassword(password, _token).then((response) => {
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