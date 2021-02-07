import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Model/getChildList_Model.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/student_list.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StudentList/getStudentDetails.dart';

class ParentHomePage extends StatefulWidget {
  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {

  bool isLoading = false;
  bool isLoaded = false;

  Map<String, double> dataMap = {
    "Total fee": 20500,
    "Pending fee": 10500,
    "Today sent fee": 5000,
  };

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  List<GetChildListModel> _getChild = [];


  var formatter;
  DateTime now;
  @override
  void initState() {

    super.initState();

    now = new DateTime.now();
    formatter = new DateFormat.yMMMMd('en_US');

    getChildList();

  }

  getChildList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String mob = sharedPreferences.getString('MOB');

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "MobileNo" : mob
      };
      var res = await CallApi().postData(data,"getChildList");
      var body = json.decode(res.body);
      // print(body);
      {
        List cartList = body as List;
        _getChild = cartList.map<GetChildListModel>((json) => GetChildListModel.fromJson(json)).toList();


        setState(() {
          isLoading =false;
          isLoaded = true;
        });
      }

    } catch (exception) {
      print('$exception');
    }
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String formattedDate = formatter.format(now);

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
      body: isLoaded ?  SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.only(left: 20,top: 20,bottom: 25),
                child: Text(formattedDate !=null ? formattedDate : '',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 100),
                  chartLegendSpacing: 62,
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 30,
                  centerText: "Fee\n Graph",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat-semibold'
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      chartValueBackgroundColor: AppColors.primaryColor,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: true,
                      chartValueStyle: TextStyle(
                          fontFamily: 'Montserrat-semibold',
                          color: AppColors.black
                      )
                  ),
                ),
              ),

              SizedBox(height: 50,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentList()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide()
                          )
                        ),
                        child: Text('Total fee Payable check details =>',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.appBarColor
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              ListView.builder(
                shrinkWrap: true,
                itemCount: _getChild.length,
                  itemBuilder: (context,index){
                    var sr = index+1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetStudentDetail(
                            studentId: _getChild[index].StudAcadID,)));

                        },
                        child: Card(
                          color: AppColors.white_10,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Container(
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: Text(sr.toString()+'.',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold
                                          ),),
                                      ),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(_getChild[index].FullName,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              SizedBox(height: 2,),
                                              Row(
                                                children: [
                                                  Text('Student Id : ',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  Expanded(
                                                    child: Text(_getChild[index].StudAcadID,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              Row(
                                                children: [
                                                  Text('Class : ',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  Expanded(
                                                    child: Text(_getChild[index].ClassName,
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
                                                    child: Text(_getChild[index].RollNo,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                      /*CircleAvatar(
                                        radius: 30,
                                        child:  Image.asset('assets/icon/as.png'),
                                      ),*/
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  /*Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Pending Fee : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      SizedBox(width: 5,),
                                      Text('25000',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Image.asset('assets/icon/rupee.png',height: 15),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: RaisedButton(
                                          color: AppColors.appBarColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          ),

                                          child: Text('Pay Now',style: TextStyle(
                                              color: AppColors.white_00,
                                              fontSize: 13,
                                              fontFamily: 'Montserrat-SemiBold'
                                          ),),
                                          onPressed: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                                          },
                                        ),
                                      )
                                    ],
                                  ),*/


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
