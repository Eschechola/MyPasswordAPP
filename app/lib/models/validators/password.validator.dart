import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';
import 'base.validator.dart';

class PasswordValidator extends BaseValidator<Password>{
	
  @override
  void validate(Password password){
    
    //customerID
    if(password.customerId == null)
      errors.add(new ErrorsValidation(inputType: InputType.customerId, error: "O ID do usuário não pode ser nulo."));

    //title
    if(password.title == null || password.title == "")
      errors.add(new ErrorsValidation(inputType: InputType.title, error: "O título da senha não pode ser vazio."));

    if(password.title.length < 3 || password.title.length > 40)
      errors.add(new ErrorsValidation(inputType: InputType.title, error: "O título da senha deve ter entre 3 e 40 caracteres."));

    //value
    if(password.value == null || password.value == "")
      errors.add(new ErrorsValidation(inputType: InputType.value, error: "O valor da senha não pode ser vazio."));

	 if(password.value.length > 400)
	 	errors.add(new ErrorsValidation(inputType: InputType.value, error: "O valor da senha deve ter no máximo 400 caracteres."));
  }
}