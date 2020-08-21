import 'package:flutter/widgets.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';

class ErrorsValidation{
  InputType inputType;
  String error;

  ErrorsValidation({@required this.inputType, @required this.error});
}