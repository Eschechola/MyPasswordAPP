import 'package:flutter/widgets.dart';

class ResponseModel{
  String message;
  bool success;
  dynamic data;

  ResponseModel({@required this.message, @required this.success, @required this.data});

  ResponseModel convertApiResponseToResponseModel(dynamic response){
    return new ResponseModel(
      message: response['message'],
      success: response['success'],
      data: response['data']
    );
  }
}