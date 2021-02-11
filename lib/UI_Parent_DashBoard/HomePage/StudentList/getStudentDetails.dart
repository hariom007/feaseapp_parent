import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Model/InstallmentListModel.dart';
import 'package:parent_institute/Model/parentProfileModel.dart';
import 'package:parent_institute/Model/studentListForPaymentModel.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check.dart';

class GetStudentDetail extends StatefulWidget {
  String studentId;
  GetStudentDetail({Key key,this.studentId}) : super(key: key);

  @override
  _GetStudentDetailState createState() => _GetStudentDetailState();
}

class _GetStudentDetailState extends State<GetStudentDetail> {

  var install_status = List<bool>();
  int total_amount_payble=0;
  List checkList= [];

  bool isLoading = false;
  bool isLoaded = false;
  List<InstallmentListModel> installmentList = [];
  StudentListForPaymentModel studentListForPayment;
  SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String API_KEY,API_SECRET ;

  ParentProfileModel parentProfileModel;

  Future getParentProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String mob = sharedPreferences.getString('MOB');

    try {

      var data ={
        "MobileNo" : mob
      };
      var res = await CallApi().postData2(data,"GetParentPersonalDetail");
      var body = json.decode(res.body);
      print(body);

      parentProfileModel = ParentProfileModel.fromJson(body);
      print(parentProfileModel.MobileNo);

    } catch (exception) {
      print('$exception');
    }
  }

  void showInSnackBar(String args) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
            backgroundColor: AppColors.appBarColor,
            content: new Text(args,style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat-Semibold'
            ),)
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPaymentDetails();
  }
  getCurrentPaymentDetails() async {

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "StudAcadID" : '${widget.studentId}'
      };
      // print(data);
      var res = await CallApi().postData(data, "getCurrentPaymentDetails");
      var body = json.decode(res.body);
      // print(body);

        API_KEY = body['WorkingKey'];
        API_SECRET = body['AccessCode'];

        List installList = body['InstallmentList'] as List;

        installmentList = installList.map<InstallmentListModel>((json) => InstallmentListModel.fromJson(json)).toList();
        for (var u in installList) {
        install_status.add(false);
        }

        var stuListForPay = body;
        studentListForPayment = StudentListForPaymentModel.fromJson(stuListForPay);

        await getParentProfile();

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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body:isLoaded ?
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Student Name : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                          ),),
                        Expanded(
                          child: Text(studentListForPayment.FullName,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('Student Id : ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        Expanded(
                          child: Text(studentListForPayment.StudAcadID,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('Course : ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        Expanded(
                          child: Text(studentListForPayment.Course,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('Total Fees : ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        Expanded(
                          child: Text(studentListForPayment.TotalFees,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('Paid Amount : ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        Expanded(
                          child: Text(studentListForPayment.PaidAmount,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('Balance Amount : ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        Expanded(
                          child: Text(studentListForPayment.BalAmount,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.red_00
                            ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: AppColors.grey_00,),
              SizedBox(height: 10,),

              installmentList.length !=0  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide()
                          )
                      ),
                      child: Text('Your Installment List Here =>',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black
                        ),),
                    ),
                  ],
                ),
              ) : Container(),
              installmentList.length !=0  ? SizedBox(height: 10,) : Container(),

              ListView.builder(
                itemCount: installmentList.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  var sr = index+1;
                    return Card(
                      elevation: 2,
                      child: CheckboxListTile(
                        activeColor: AppColors.appBarColor,
                        value: install_status[index],
                        onChanged: (bool value) {
                          setState(() {
                            install_status[index] = !install_status[index];
                            var send = {
                              "Installid" : installmentList[index].Installid
                            };
                            if(value==true){

                              int abc = int.parse(installmentList[index].InstallmentAmount);
                              total_amount_payble = total_amount_payble+abc;

                              checkList.add(send);

                            }
                            else{
                              int abc = int.parse(installmentList[index].InstallmentAmount);
                              total_amount_payble = total_amount_payble-abc;
                              checkList.removeWhere((element) => element['Installid'] == installmentList[index].Installid);
                            }
                          });
                        },
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0,right: 8),
                                    child: Text(sr.toString()+ '.',
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
                                              Text('Installment id : ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Expanded(
                                                child: Text(installmentList[index].Installid,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2,),
                                          Row(
                                            children: [
                                              Text('Installment Name : ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Expanded(
                                                child: Text(installmentList[index].Installment,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2,),
                                          Row(
                                            children: [
                                              Text('Installment Amount : ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Expanded(
                                                child: Text(installmentList[index].InstallmentAmount,
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
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(top: 6),
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

                    int length = installmentList.length;
                    if(length == 0){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => CheckRazor(
                            stuId : studentListForPayment.StudAcadID,
                            installList : checkList,
                            amt: (int.parse(studentListForPayment.BalAmount)*100).toString(),
                            mobile: parentProfileModel.MobileNo,
                            email: parentProfileModel.EmailID,
                            API_KEY : API_KEY,
                            API_SECRET : API_SECRET
                        ),
                      ),
                            (Route<
                            dynamic> route) => false,
                      );
                    }
                    else {
                      if(checkList.length ==0){
                        showInSnackBar('Please select one Installment');
                      }
                      else{
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (context) => CheckRazor(
                              stuId : studentListForPayment.StudAcadID,
                              installList : checkList,
                              amt:  (total_amount_payble *100).toString(),
                              mobile: parentProfileModel.MobileNo,
                              email: parentProfileModel.EmailID,
                              API_KEY : API_KEY,
                              API_SECRET : API_SECRET
                          ),
                        ),
                              (Route<
                              dynamic> route) => false,
                        );
                      }
                    }



                  },
                ),
              ),
            ],
          ),
        ),
      ):
      Center(child: CircularProgressIndicator(),),
    );
  }
}

/*Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Card(
                        color: AppColors.white_10,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      child: Text(sr.toString()+ '.',
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
                                                Text('Installment id : ',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                Expanded(
                                                  child: Text(installmentList[index].Installid,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Row(
                                              children: [
                                                Text('Installment Name : ',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                Expanded(
                                                  child: Text(installmentList[index].Installment,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Row(
                                              children: [
                                                Text('Installment Amount : ',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                Expanded(
                                                  child: Text(installmentList[index].InstallmentAmount,
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
                                Container(
                                  width: width,
                                  padding: EdgeInsets.only(top: 6),
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
                                      var final_amount = int.parse(installmentList[index].InstallmentAmount)*100;
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckRazor(
                                                  amt: final_amount
                                                      .toString(),
                                                  mobile: parentProfileModel.MobileNo,
                                                  email: parentProfileModel.EmailID,
                                                  API_KEY : API_KEY,
                                                  API_SECRET : API_SECRET
                                              ),
                                        ),
                                            (Route<
                                            dynamic> route) => false,
                                      );


                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )*/