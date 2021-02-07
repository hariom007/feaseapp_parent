import 'dart:convert';

import 'package:flutter/material.dart';
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


  bool isLoading = false;
  bool isLoaded = false;
  List<InstallmentListModel> installmentList = [];
  List<StudentListForPaymentModel> studentListForPayment = [];
  SharedPreferences sharedPreferences;

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

        API_KEY = body['PaymentGatewaykeys'][0]['WorkingKey'];
        API_SECRET = body['PaymentGatewaykeys'][0]['AccessCode'];

        List installList = body['InstallmentList'] as List;

        installmentList = installList.map<InstallmentListModel>((json) => InstallmentListModel.fromJson(json)).toList();

        List stuListForPay = body['StudentListForPayment'] as List;
        studentListForPayment = stuListForPay.map<StudentListForPaymentModel>((json) => StudentListForPaymentModel.fromJson(json)).toList();

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
              ListView.builder(
                shrinkWrap: true,
                itemCount: studentListForPayment.length,
                  itemBuilder: (context,index){
                    return Container(
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
                                child: Text(studentListForPayment[index].FullName,
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
                                child: Text(studentListForPayment[index].StudAcadID,
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
                                child: Text(studentListForPayment[index].Course,
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
                                child: Text(studentListForPayment[index].TotalFees,
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
                                child: Text(studentListForPayment[index].PaidAmount,
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
                                child: Text(studentListForPayment[index].BalAmount,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.red_00
                                  ),),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
              SizedBox(height: 10,),
              Divider(color: AppColors.grey_00,),
              SizedBox(height: 10,),

              Padding(
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
              ),
              SizedBox(height: 10,),

              ListView.builder(
                itemCount: installmentList.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  var sr = index+1;
                    return Padding(
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
                    );
                  }
              ),
            ],
          ),
        ),
      ):
      Center(child: CircularProgressIndicator(),),
    );
  }
}
