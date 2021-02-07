import 'package:flutter/material.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/Values/AppColors.dart';

class StudentDetail extends StatefulWidget {
  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
            height: 80,
            width: width,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.2)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
              child: Image.asset(
                'assets/logo/sample_logo.png',
                fit: BoxFit.fill,
                width: 160,
                height: 70,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide()
                    )
                  ),
                  child: Text('Student Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: AppColors.white_10,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: Text('1.',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Student Name : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('Hariom J Gupta',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Text('Student Class : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('9th B',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Text('Roll no. : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('17',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Card(
                color: AppColors.white_10,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: Text('2.',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Student Name : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('Sunny S Soni',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Text('Student Class : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('8th A',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Text('Roll no. : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                        child: Text('01',
                                          style: TextStyle(
                                              fontSize: 13,
                                          ),),
                                    )
                                  ],
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: width,
                // margin: EdgeInsets.only(left: 20,right: 20,bottom: 40,top: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5,
                        color: AppColors.primaryColor
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: RaisedButton(

                  color: AppColors.appBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 17.0,
                  ),
                  child: Text('Accept & Continue',style: TextStyle(
                      color: AppColors.white_00,
                      fontSize: 15,
                      fontFamily: 'Montserrat-SemiBold'
                  ),),
                  onPressed: () {
                    MyParentNavigator.goToKillDashBoard(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>InstituteVerify()));

                  },
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
