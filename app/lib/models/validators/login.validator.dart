
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';

import 'base.validator.dart';
import 'errorsValidation.model.dart';

class LoginValidator extends BaseValidator<Login>{
	
  @override
  void validate(Login login){
    //email
    if(login.email == null || login.email == "")
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email do usuário não pode ser vazio."));

    if(login.email.length < 10 || login.email.length > 180)
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email deve ter entre 10 e 180 caracteres."));

    RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(!emailValidator.hasMatch(login.email))
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email digitado não é válido."));

    //password
    if(login.password == null || login.password == "")
      errors.add(new ErrorsValidation(inputType: InputType.password, error: "A senha do usuário não pode ser vazia."));

  }
}