import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypassword/blocs/bloc/customer.bloc.dart';
import 'package:mypassword/blocs/bloc/navigation.bloc.dart';
import 'package:mypassword/blocs/bloc/password.bloc.dart';
import 'package:mypassword/pages/dashboard.page.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:mypassword/widgets/mypassword.alertDialog.dart';
import 'package:mypassword/widgets/mypassword.toast.widget.dart';

class MyPassowrdBottomSheetMenu extends StatefulWidget {
  int passwordId;
  String passwordName;
  String passwordValue;
  bool passwordHidden = true;

  String get passwordValueEncoded {
    String valueEncoded = "";

    for (int i = 0; i < passwordValue.length; i++)
      valueEncoded += "*";

    return valueEncoded;
  }

  MyPassowrdBottomSheetMenu(
      {@required this.passwordId,
      @required this.passwordName,
      @required this.passwordValue});

  @override
  _MyPassowrdBottomSheetMenuState createState() =>
      _MyPassowrdBottomSheetMenuState();
}

class _MyPassowrdBottomSheetMenuState extends State<MyPassowrdBottomSheetMenu> {
  void viewPassword() {
    setState(() {
      widget.passwordHidden = !widget.passwordHidden;
    });
  }

  Future _pushModalDeletePassword() async {
    var modalButtons = new List<Widget>();

    //ADICIONA OS BOTOÕES DO MODAL
    modalButtons.add(
      FlatButton(
        child: Text(
          "NÃO",
          style: TextStyle(
            fontSize: 18
          ),
        ),
        textColor: AppColors.thirdColor,
        onPressed: (){
          NavigationBloc().pop(context);
        }
      )
    );
    
    modalButtons.add(
      FlatButton(
        child: Text(
          "SIM",
          style: TextStyle(
            fontSize: 18
          ),
        ),
        textColor: AppColors.thirdColor,
        onPressed: (){
          _deletePassword(widget.passwordId);
        }
      )
    );

    MyPasswordAlertDialog(
      'EXCLUSÃO DE SENHA',
      'Deseja realmente excluir a senha: \'${widget.passwordName}\'?',
      context,
      modalButtons
    )
    .showModalDialog();
  }

  Future _deletePassword(int id) async{
    await PasswordBloc().deletePassword(id).then((response) => {
      if(response.success)
        new NavigationBloc().popAllAndReplace(context, new DashboardPage()),

      MyPasswordToast.showToast(response.message, context)
    });
  }

  void _updatePassword(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(50),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.lock,
                          color: AppColors.secondaryColor,
                          size: 50,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    this.widget.passwordName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      widget.passwordHidden
                                          ? widget.passwordValueEncoded
                                          : this.widget.passwordValue,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.cardText,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 0, left: 40),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            widget.passwordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.secondaryColor,
                          ),
                          title: Text(
                            widget.passwordHidden ? "Visualizar" : "Esconder",
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 20),
                          ),
                          onTap: viewPassword,
                        ),
                        ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: AppColors.secondaryColor,
                            ),
                            title: Text(
                              "Editar",
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 20),
                            ),
                            onTap: _updatePassword),
                        ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: AppColors.secondaryColor,
                          ),
                          title: Text(
                            "Deletar",
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 20),
                          ),
                          onTap: _pushModalDeletePassword
                        ),
                      ],
                    ))
              ],
            ))
      ],
    ));
  }
}
