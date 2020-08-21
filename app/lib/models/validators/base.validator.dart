import 'package:mypassword/models/validators/errorsValidation.model.dart';

class BaseValidator<T> {
  List<ErrorsValidation> errors = new List<ErrorsValidation>();

  void validate(T object){}
}