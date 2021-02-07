import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), (){
   _checkIfLoggedIn();
    });

  }

  bool _isLoggedIn= false;
  bool isLoading = false;
  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var instCode = localStorage.getString('uid');
    if (instCode != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }

    if (_isLoggedIn) {

      MyParentNavigator.goToKillDashBoard(context);

    }
    else{
      MyParentNavigator.goToLoginPage(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/sample_logo.png',height: 200,width: 300,fit: BoxFit.contain,),
            SizedBox(height: height/4,),
            SpinKitRing(color: AppColors.appBarColor,size: 60,)
          ],
        )
      ),
    );
  }
}
