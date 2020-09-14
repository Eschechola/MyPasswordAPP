import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/login.model.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';
import 'package:mypassword/models/validators/login.validator.dart';
import 'package:mypassword/pages/dashboard.page.dart';
import 'package:mypassword/pages/register.page.dart';
import 'package:mypassword/settings/settings.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassowrd.logo.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';
import 'package:mypassword/widgets/mypassword.toast.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  bool rememberController = true;

  final emailController = TextEditingController();
  List<ErrorsValidation> emailErrors = new List<ErrorsValidation>();

  final passwordController = TextEditingController();
  List<ErrorsValidation> passwordErrors = new List<ErrorsValidation>();

  void _pushRegisterPage(){
     NavigationBloc().pushReplacementTo(context, RegisterPage());
  }

  void _pushDashboardPage(){
     NavigationBloc().popAllAndReplace(context, DashboardPage());
  }

  void _clearErrors(InputType inputType){
    setState(() {
        switch(inputType){
          case InputType.email:
            emailErrors.clear();
          break;

          case InputType.password:
            passwordErrors.clear();
          break;
      }
    });
  }

  void _addError(ErrorsValidation error){
    setState(() {
      switch(error.inputType){
        case InputType.email:
          emailErrors.add(error);
        break;

        case InputType.password:
          passwordErrors.add(error);   
        break;
      }
    });
  }

  void _enableLoading(){
    setState(() {
      isLoading = true;
    });
  }

  void _disableLoading(){
    setState(() {
      isLoading = false;
    });
  }

  void _cleanAllErrors(){
    emailErrors.clear();
    passwordErrors.clear();
  }

  Future _loginUser() async {
    try{
      _enableLoading();

      var loginCustomer = new Login(
        email: emailController.text,
        password: passwordController.text,
        remember: rememberController
      );

      var validator = new LoginValidator();
      validator.validate(loginCustomer);

      if(validator.errors.length > 0){
        for(var error in validator.errors){
          _addError(error);    
        }

        _disableLoading();
        MyPasswordToast.showToast(Settings.INVALID_INPUTS_MESSAGE, context);
      }
      else{
        await new CustomerBloc().loginCustomer(loginCustomer).then((result) => {
          //limpa os erros
          _cleanAllErrors(),
                  
          //caso tenha registrado com sucesso, chama a homepage
          if(result.success){
            _pushDashboardPage()
          }
          else{
            MyPasswordToast.showToast(result.message, context),
            _disableLoading()
          }
        });
      }
    }
    catch(ex){
      MyPasswordToast.showToast(ex.toString(), context);
      _disableLoading();
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

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1
              ),
              child: Column(
                children: <Widget>[
                  MyPasswordInput(
                    controller: emailController,
                    hintText: "Digite seu email...",
                    keyboardType: TextInputType.text,
                    errors: emailErrors,
                  ),

                  MyPasswordInput(
                    controller: passwordController,
                    hintText: "Digite sua senha...",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    errors: passwordErrors,
                  ),
                  
                  CheckboxListTile(
                    title: Text(
                      "Lembrar de mim",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18
                      ),
                    ),
                    activeColor: AppColors.thirdColor,
                    checkColor: AppColors.secondaryColor,
                    value: rememberController,
                    onChanged: (value) {
                      setState(() {
                        rememberController = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 28,
                      bottom: 50
                    ),
                    
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Ainda não tem uma conta? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.secondaryColor
                          ),
                        ),

                        InkWell(
                          onTap: _pushRegisterPage,
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.6)
                            ),
                          )
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03
                    ),
                    child: 
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
                        text: "Entrar",
                        function: _loginUser,
                        inverseButton: false,
                      )
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}