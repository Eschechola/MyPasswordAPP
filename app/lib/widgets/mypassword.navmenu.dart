import 'package:flutter/material.dart';
import 'package:mypassword/styles/app.colors.dart';

import 'mypassowrd.logo.widget.dart';

class NavMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07), child: MyPasswordLogo())),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: AppColors.secondaryColor,
                    ),
                    title: Text(
                      "Dashboard",
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20),
                    ),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: AppColors.secondaryColor,
                    ),
                    title: Text(
                      "Configurações",
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20),
                    ),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.sync,
                      color: AppColors.secondaryColor,
                    ),
                    title: Text(
                      "Sincronização",
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20),
                    ),
                    onTap: () => {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.30,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: AppColors.secondaryColor,
                      ),
                      title: Text(
                        "Sobre",
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 20),
                      ),
                      onTap: () => {},
                    ),
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: AppColors.secondaryColor,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 20),
                      ),
                      onTap: () => {},
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
