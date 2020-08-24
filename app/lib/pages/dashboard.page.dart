import 'package:flutter/material.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/models/entities/customer.model.dart';
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
  
  void pushCreatePasswordPage(){
     NavigationBloc().pushTo(context, ManagePasswordPage());
  }

  void callModalShowPassword(context, passwordId, passwordName, passwordValue){
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

  @override
  void initState() {
    //pega os dados de sessão do usuário
    _getCustomerSession();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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
                        callModalShowPassword(context, 1, "Senha do email", "123");
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
        onPressed: pushCreatePasswordPage,//pushCreatePasswordPage,
        backgroundColor: AppColors.thirdColor,
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}