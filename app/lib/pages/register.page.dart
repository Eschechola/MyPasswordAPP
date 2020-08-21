import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/enums/customerType.enum.dart';
import 'package:mypassword/models/validators/customer.validator.dart';
import 'package:mypassword/pages/dashboard.page.dart';
import 'package:mypassword/settings/settings.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassowrd.logo.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';
import 'package:mypassword/widgets/mypassword.toast.widget.dart';

import 'login.page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;

  final nameController = TextEditingController();
   List<ErrorsValidation> nameErrors = new List<ErrorsValidation>();

  final emailController = TextEditingController();
  List<ErrorsValidation> emailErrors = new List<ErrorsValidation>();

  final passwordController = TextEditingController();
  List<ErrorsValidation> passwordErrors = new List<ErrorsValidation>();

  final confirmPasswordController = TextEditingController();
  List<ErrorsValidation> confirmPasswordErrors = new List<ErrorsValidation>();

  void pushLoginPage(){
      NavigationBloc().pushReplacementTo(context, LoginPage());
  }

  void pushDashboardPage(){
      NavigationBloc().popAllAndReplace(context, DashboardPage());
  }

  void enableLoading(){
    setState(() {
      isLoading = true;
    });
  }

  void disableLoading(){
    setState(() {
      isLoading = false;
    });
  }

  void cleanAllErrors(){
    nameErrors.clear();
    emailErrors.clear();
    passwordErrors.clear();
    confirmPasswordErrors.clear();
  }


  void clearErrors(InputType inputType){
    setState(() {
        switch(inputType){
          case InputType.name:
            nameErrors.clear();
          break;

          case InputType.email:
            emailErrors.clear();
          break;

          case InputType.password:
            passwordErrors.clear();
          break;

          case InputType.confirmPassword:
            confirmPasswordErrors.clear();
          break;
      }
    });
  }

  void addError(ErrorsValidation error){
    setState(() {
      switch(error.inputType){
        case InputType.name:
          nameErrors.add(error);
        break;

        case InputType.email:
          emailErrors.add(error);
        break;

        case InputType.password:
          passwordErrors.add(error);   
        break;

        case InputType.confirmPassword:
          confirmPasswordErrors.add(error);
        break;
      }
    });
  }

  void registerCustomer() async {
    try{
        enableLoading();
            
        //entidade do usuário
        var customer = new Customer(
            name: nameController.text.trimRight().trimLeft(),
            email: emailController.text.trimRight().trimLeft(),
            password: passwordController.text,
            type: CustomerType.normal,
            confirmPassword: confirmPasswordController.text
          );

          //valida os dados do cliente
          var validator = new CustomerValidator();
          validator.validate(customer);

            if(validator.errors.length > 0){
              for(var error in validator.errors){
                addError(error);    
              }

              disableLoading();
              MyPasswordToast.showToast(Settings.INVALID_INPUTS_MESSAGE, context);
            }
            else{
              await new CustomerBloc().registerCustomer(customer).then((result) => {
                  //limpa os erros
                  cleanAllErrors(),
                  
                  //caso tenha registrado com sucesso, chama a homepage
                  if(result.success){
                    pushDashboardPage()
                  }
                  else{
                    MyPasswordToast.showToast(result.message, context),
                    disableLoading()
                  }
              });
            }
        }
        catch(ex){
          MyPasswordToast.showToast(ex.toString(), context);
          disableLoading();
        }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: ListView(
          children: <Widget>[

            MyPasswordLogo(),

            MyPasswordInput(
              controller: nameController,
              hintText: "Digite seu nome...",
              keyboardType: TextInputType.text,
              errors: nameErrors,
              onChanged: (String arg){
                clearErrors(InputType.name);
              }
            ),

            MyPasswordInput(
              controller: emailController,
              hintText: "Digite seu email...",
              keyboardType: TextInputType.emailAddress,
              errors: emailErrors,
              onChanged: (String arg){
                clearErrors(InputType.email);
              }
            ),

            MyPasswordInput(
              controller: passwordController,
              hintText: "Digite sua senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
              errors: passwordErrors,
              onChanged: (String arg){
                clearErrors(InputType.password);
              }
            ),

            MyPasswordInput(
              controller: confirmPasswordController,
              hintText: "Digite novamente sua senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
              errors: confirmPasswordErrors,
              onChanged: (String arg){
                clearErrors(InputType.confirmPassword);
              }
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: 28,
                bottom: 15
              ),
              
              child: Row(
                children: <Widget>[
                  Text(
                    "Já tem tem conta? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryColor
                    ),
                  ),

                  InkWell(
                    onTap: pushLoginPage,
                    child: Text(
                      "Entre aqui",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 255, 255, 0.6)
                      ),
                    )
                  ),
                ],
              ),
            ),

            isLoading ? 
            MyPasswordButton(
              text: '',
              inverseButton: false,
              iconButton: true,
              iconWidget: CircularProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
              ),
              function: (){},
            )
            : MyPasswordButton(
              inverseButton: false,
              function: registerCustomer,
              text: "Cadastre - se",
            ),
          ],
        )
      ),
    );
  }
}