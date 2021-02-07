import 'package:flutter/material.dart';

class MyParentNavigator{

  static void goToKillDashBoard(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);

  }

  static void goToLoginPage(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil('/logIn', (route) => false);
  }
  static void goToMYProfile(BuildContext context){
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProfile()));
  }

}