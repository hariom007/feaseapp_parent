import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Model/parentProfileModel.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/UI_Parent_DashBoard/ParentProfile/PaymentHistory/payment_history.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentProfilePage extends StatefulWidget {
  @override
  _ParentProfilePageState createState() => _ParentProfilePageState();
}

class _ParentProfilePageState extends State<ParentProfilePage> {


  bool isLoading = false;
  bool isLoaded = false;

  ParentProfileModel parentProfileModel;

  @override
  void initState() {
    super.initState();
    getParentProfile();

  }

  getParentProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String mob = sharedPreferences.getString('MOB');

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "MobileNo" : mob
      };
      var res = await CallApi().postData2(data,"GetParentPersonalDetail");
      var body = json.decode(res.body);
      print(body);

        parentProfileModel = ParentProfileModel.fromJson(body);

        print(parentProfileModel.FatherName);

        setState(() {
          isLoading =false;
          isLoaded = true;
        });

    } catch (exception) {
      print('$exception');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: isLoaded ?
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 0.4),
                          ),
                          child: CircleAvatar(
                              radius: 42,
                              backgroundColor: AppColors.white_90,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage('assets/icon/as.png',),
                                        fit: BoxFit.fill
                                    )
                                ),
                              )
                          )
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(parentProfileModel.FatherName,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red_00
                            ),),
                          Text(parentProfileModel.MobileNo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black
                            ),),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

               /* Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 0.5,
                            color: AppColors.grey_10
                        ),
                        bottom: BorderSide(
                            width: 0.5,
                            color: AppColors.grey_10
                        ),
                      )
                  ),
                  child: ListTile(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                    },
                    dense: true,
                    title: Text('Profile',
                      style: TextStyle(
                          fontFamily: 'Montserrat-regular',
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey_10
                      ),),
                    trailing: Icon(Icons.person_outline,color: AppColors.primaryColorDark,),
                  ),
                ),*/
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 0.5,
                            color: AppColors.grey_10
                        ),
                        bottom: BorderSide(
                            width: 0.5,
                            color: AppColors.grey_10
                        ),
                      )
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentHistory()));
                    },
                    dense: true,
                    title: Text('Payment History',
                      style: TextStyle(
                          fontFamily: 'Montserrat-regular',
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey_10
                      ),
                    ),
                    trailing: Image.asset('assets/icon/rs.png',color: AppColors.primaryColorDark,height: 23,),
                  ),
                ),

              ],
            ),


            Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 0.5,
                        color: AppColors.grey_10
                    ),
                    bottom: BorderSide(
                        width: 0.5,
                        color: AppColors.grey_10
                    ),
                  )
              ),
              child: ListTile(
                onTap: (){
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Exit',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-SemiBold',
                            ),),
                          content: Text(
                            'Are you sure you want to Logout?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat-Regular',
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Logout',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryColorDark,
                                  fontFamily: 'Montserrat-SemiBold',
                                ),),
                              onPressed: () async{
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                MyParentNavigator.goToLoginPage(context);

                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: FlatButton(
                                child: Text('Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.appBarColor,
                                    fontFamily: 'Montserrat-SemiBold',
                                  ),),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],

                        );
                      }
                  );
                },
                dense: true,
                title: Text('Logout',
                  style: TextStyle(
                      fontFamily: 'Montserrat-regular',
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey_10
                  ),),
                trailing: Icon(Icons.exit_to_app,color: AppColors.primaryColorDark,),
              ),
            ),

          ],
        ),
      ) :
      Center(child: CircularProgressIndicator(),),
    );
  }
}
