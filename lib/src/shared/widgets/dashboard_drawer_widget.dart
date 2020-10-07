import 'dart:io';

import 'package:bucks/src/login/login_module.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';

class DashboardDrawerWidget extends StatelessWidget {
  bool screen = false;

  @override
  Widget build(BuildContext context) {
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
              // currentAccountPicture: CircleAvatar(
              //   child: Image.asset("images/user.png"),
              // ),
            ),
            ListTile(
              onTap: () {
                _logout(context);
              },
              title: Text(
                "Logout",
                style: TextStyle(fontSize: screen ? 16 : 20),
              ),
              leading: Icon(Icons.close),
            ),
            ListTile(
              onTap: () => exit(0),
              title: Text(
                "Sair",
                style: TextStyle(fontSize: screen ? 16 : 20),
              ),
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(context) {
    pushReplacement(context, LoginModule());
  }
}
