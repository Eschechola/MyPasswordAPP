import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/blocs/bloc/password.bloc.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/models/enums/inputType.enum.dart';
import 'package:mypassword/models/validators/errorsValidation.model.dart';
import 'package:mypassword/models/validators/password.validator.dart';
import 'package:mypassword/pages/dashboard.page.dart';
import 'package:mypassword/settings/settings.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.appBar.widget.dart';
import 'package:mypassword/widgets/mypassword.button.widget.dart';
import 'package:mypassword/widgets/mypassword.input.widget.dart';
import 'package:mypassword/widgets/mypassword.navmenu.dart';
import 'package:mypassword/widgets/mypassword.toast.widget.dart';

class ManagePasswordPage extends StatefulWidget {
  @override
  _ManagePasswordPage createState() =>_ManagePasswordPage();
}

class _ManagePasswordPage extends State<ManagePasswordPage> {
  Customer _customer;

  bool acceptedTerms = true;

  bool isLoading = false;

   final titleController = TextEditingController();
   List<ErrorsValidation> titleErrors = new List<ErrorsValidation>();

  final valueController = TextEditingController();
  List<ErrorsValidation> valueErrors = new List<ErrorsValidation>();

  Future _initPage() async{
    await _getCustomerSession();
  }

  Future _getCustomerSession() async{
    await new CustomerBloc().getCustomerSession().then((value) => {
      _setCustomerSession(value)
    });
  }

  void _setCustomerSession(Customer customer){
    setState(() {
      _customer = customer;
    });
  }

  void _clearErrors(InputType inputType){
    setState(() {
        switch(inputType){
          case InputType.value:
            valueErrors.clear();
          break;

          case InputType.title:
            titleErrors.clear();
          break;
      }
    });
  }

  void _addError(ErrorsValidation error){
    setState(() {
      switch(error.inputType){
        case InputType.title:
          titleErrors.add(error);
        break;

        case InputType.value:
          valueErrors.add(error);   
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
    titleErrors.clear();
    valueErrors.clear();
  }

  Future _insertPassword() async {
    try
    {
      _enableLoading();

      var password = new Password(
        customerId: _customer.id,
        title: titleController.text,
        value: valueController.text,
      );

      //caso não tenha aceito os termos
      if(!acceptedTerms){
        MyPasswordToast.showToast(Settings.NOT_ACCEPT_USE_TERMS, context);
        return;
      }

      var validator = new PasswordValidator();
      validator.validate(password);

      if(validator.errors.length > 0)
      {
        for(var error in validator.errors){
          _addError(error);    
        }

        _disableLoading();
        MyPasswordToast.showToast(Settings.INVALID_INPUTS_MESSAGE, context);
      }
      else{
        await new PasswordBloc().insertPassword(password).then((result) => {
          //limpa os erros
          _cleanAllErrors(),

          MyPasswordToast.showToast(result.message, context),

          if(result.success)
            NavigationBloc().popAllAndReplace(context, new DashboardPage())
          
          else
            _disableLoading()
        });
      }
    }
    catch(ex)
    {
      MyPasswordToast.showToast(ex.toString(), context);
      _disableLoading();
    }
  }

  @override
  void initState() {
    _initPage();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: MyPasswordAppBar(
        title: "Criar Nova Senha"
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 90),
              child: Text(
                "Preencha os campos a seguir para criar uma nova senha",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 25
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30),
            ),

            MyPasswordInput(
              hintText: "Digite de onde é a senha...",
              keyboardType: TextInputType.text,
              controller: titleController,
              errors: titleErrors,
            ),

            MyPasswordInput(
              hintText: "Digite a senha...",
              keyboardType: TextInputType.text,
              isPassword: true,
              controller: valueController,
              errors: valueErrors,
            ),

            CheckboxListTile(
              title: Row(children: <Widget>[
                    Text(
                      "Concordo com os ",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18
                      ),
                    ),

                    Text(
                      "TERMOS DE USO",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                activeColor: AppColors.thirdColor,
                checkColor: AppColors.secondaryColor,
                value: acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    acceptedTerms = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading
              ),

              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.07),
              ),

              MyPasswordButton(
                function: _insertPassword,
                inverseButton: false,
                text: "Salvar",
              )
          ],
        )
      ),
    );
  }
}