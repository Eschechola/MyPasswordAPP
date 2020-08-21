import 'package:flutter/widgets.dart';

class ResponseModel{
  String message;
  bool success;
  dynamic data;

  ResponseModel({@required this.message, @required this.success, @required this.data});
}