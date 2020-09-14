import 'package:flutter/widgets.dart';

class ResponseModel{
  String message;
  bool success;
  dynamic data;

  ResponseModel({this.message, this.success, this.data});

  ResponseModel convertApiResponseToResponseModel(dynamic response){
    return new ResponseModel(
      message: response['message'],
      success: response['success'],
      data: response['data']
    );
  }
}