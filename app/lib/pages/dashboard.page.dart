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
  Customer _customer = null;
  List<Password> _passwordsList = new List<Password>();
  
  void _initPage() async {
    await _getCustomerSession();
    await _getAllPasswords(_customer.id, _customer.token);
  }

  void _convertResponseModelInPasswordList(dynamic response){
    for(var password in response.data){
      _passwordsList.add(new Password(
        id: password["id"],
        customerId: password["customerId"],
        title: password["title"],
        value: password["value"]
      ));
    }
  }

  void _getCustomerSession() async{
    await new CustomerBloc().getCustomerSession().then((value) => {
      _setCustomerSession(value)
    });
  }

  void _setCustomerSession(Customer customer){
    setState(() {
      _customer = customer;
    });
  }
  
  void _pushCreatePasswordPage(){
     NavigationBloc().pushTo(context, ManagePasswordPage());
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

  void _getAllPasswords(int id, String token) async{
    await new PasswordBloc().getAllPasswords(id, token).then((response) => {
      _convertResponseModelInPasswordList(response)
    });
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
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 15),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    return MyPasswordCard(
                      onTap: () { 
                        _callModalShowPassword(context, 1, "Senha do email", "123");
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
                              "Senha do email\n******",
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
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){ _getAllPasswords(_customer.id, _customer.token); },//pushCreatePasswordPage,
        backgroundColor: AppColors.thirdColor,
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}