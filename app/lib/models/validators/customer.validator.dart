import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';
import 'package:mypassword/models/validators/base.validator.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';

class CustomerValidator extends BaseValidator<Customer>{

  @override
  void validate(Customer customer){

    //name
    if(customer.name == null || customer.name == "")
      errors.add(new ErrorsValidation(inputType: InputType.name, error: "O nome do usuário não pode ser vazio."));

    if(customer.name.length < 3 || customer.name.length > 40)
      errors.add(new ErrorsValidation(inputType: InputType.name, error: "O nome deve ter entre 3 e 40 caracteres."));

    //email
    if(customer.email == null || customer.email == "")
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email do usuário não pode ser vazio."));

    if(customer.email.length < 10 || customer.email.length > 180)
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email deve ter entre 10 e 180 caracteres."));

    RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(!emailValidator.hasMatch(customer.email))
      errors.add(new ErrorsValidation(inputType: InputType.email, error: "O email digitado não é válido."));

    //password
    if(customer.password == null || customer.password == "")
      errors.add(new ErrorsValidation(inputType: InputType.password, error: "A senha do usuário não pode ser vazia."));

    if(customer.password.length < 6 || customer.password.length > 180)
      errors.add(new ErrorsValidation(inputType: InputType.password, error: "A senha deve ter entre 6 e 180 caracteres."));

    //confirm password
    if(customer.confirmPassword != customer.password)
      errors.add(new ErrorsValidation(inputType: InputType.confirmPassword, error: "As senhas estão diferentes"));
  }
}