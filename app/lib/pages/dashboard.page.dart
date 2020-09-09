import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/blocs/bloc/password.bloc.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/models/entities/password.model.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.appBar.widget.dart';
import 'package:mypassword/widgets/mypassword.bottomSheetMenu.widget.dart';
import 'package:mypassword/widgets/mypassword.card.widget.dart';
import 'package:mypassword/widgets/mypassword.homecard.widget.dart';
import 'package:mypassword/widgets/mypassword.navmenu.dart';

import 'managePassword.page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Customer _customer;
  List<Password> _passwordsList = new List<Password>();
  
  void _initPage() async {
    await _getCustomerSession();
    await _getAllPasswords(_customer.id, _customer.token);
    
    //carregando as senhas a cada 3 segundos
    _loadingPasswords();
  }

  void _loadingPasswords() async{
    while(true){
      await new Future.delayed(const Duration(seconds : 3));
      await _getAllPasswords(_customer.id, _customer.token);
    }
  }

  void _getCustomerSession() async{
    await new CustomerBloc().getCustomerSession().then((value) => {
      _setCustomerSession(value)
    });
  }

  void _getAllPasswords(int id, String token) async{
    await new PasswordBloc(token).getAllPasswords(id).then((response) => {
      _setPasswordList(_convertResponseModelInPasswordList(response))
    });
  }

  void _setPasswordList(List<Password> passwordList){
    setState(() {
      _passwordsList = passwordList;
    });
  }

  void _setCustomerSession(Customer customer){
    setState(() {
      _customer = customer;
    });
  }
  
  void _pushCreatePasswordPage() async {
     NavigationBloc().pushTo(context, ManagePasswordPage());
  }

  List<Password> _convertResponseModelInPasswordList(dynamic response){
    var passwordList = new List<Password>();

    for(var password in response.data){
      passwordList.add(new Password(
        id: password["id"],
        customerId: password["customerId"],
        title: password["title"],
        value: password["value"]
      ));
    }

    return passwordList;
  }

  void _callModalShowPassword(context, passwordId, passwordName, passwordValue){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
          return MyPassowrdBottomSheetMenu(
            passwordId: passwordId,
            passwordName: passwordName,
            passwordValue: passwordValue,
          );
      }
    );
  }

  String _convertPasswordValueToPasswordChar(String password){
    String _password = "";

    for(int i = 0; i < password.length; i++)
      _password +="*";

    return _password;
  }

  @override
  void initState() {
    _initPage();

    super.initState();
  }
  
  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: MyPasswordAppBar(
        title: "MyPassword"
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
        child: Column(
          children: <Widget>[
            MyPasswordHomeCard(
              username: _customer.name,
              isLoading: _customer.name == null,
            ),
            
            Padding(
              padding: EdgeInsets.only(
                top: 80,
                left: 20,
                right: 20,
                bottom: 30
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Aqui estão suas senhas",
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,     
                  ),
                ),
              ), 
            ),
            
            Container(
              height: MediaQuery.of(context).size.height * 0.53,
              child: 
              Scrollbar(
                child: 
                RefreshIndicator(
                  onRefresh: () async { await _getAllPasswords(_customer.id, _customer.token); },
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 15),
                    itemCount: _passwordsList.length,
                    itemBuilder: (BuildContext context, int index){
                      return MyPasswordCard(
                        onTap: () { 
                          _callModalShowPassword(context, 1, _passwordsList[index].title, _passwordsList[index].value);
                        },
                        height: 80,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.lock_outline,
                                color: AppColors.cardText,
                                size: MediaQuery.of(context).size.height * 0.05,
                              ), 
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                top: 10
                              ),
                              child: Text(
                                '''${_passwordsList[index].title}\n${_convertPasswordValueToPasswordChar(_passwordsList[index].value)}''',
                                style: TextStyle(
                                  color: AppColors.cardText,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ],
                        )
                      );
                    },
                  ),
                ),
              ),
            ), 
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:_pushCreatePasswordPage,//pushCreatePasswordPage,
        backgroundColor: AppColors.thirdColor,
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}