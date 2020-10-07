import 'package:flutter/material.dart';
import 'login/login_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BUCKS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginModule());
  }
}
