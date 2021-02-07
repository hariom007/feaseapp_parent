import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/homepage.dart';
import 'package:parent_institute/UI_Parent_DashBoard/ParentProfile/parentProfile.dart';
import 'package:parent_institute/Values/AppColors.dart';

class ParentDashBoard extends StatefulWidget {
  @override
  _ParentDashBoardState createState() => _ParentDashBoardState();
}

class _ParentDashBoardState extends State<ParentDashBoard> {

  bool showBadge = false;

  int _currentIndex = 0;
  int _pState = 0;



  @override
  Widget build(BuildContext context) {
    var pages = [new  ParentHomePage(), new  ParentProfilePage(),];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: AppColors.primaryColor,
            selectedItemColor: AppColors.primaryColorDark,
            unselectedItemColor: AppColors.appButtonColor,
            onTap: onTappedChanged,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text("DashBoard"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: new Text("My Profile"),
              )
            ],
          )
      ),
    );
  }
  void onTappedChanged(int index) {
    setState(() {
      _currentIndex = index;
      _pState=_currentIndex;
    });
  }
}
