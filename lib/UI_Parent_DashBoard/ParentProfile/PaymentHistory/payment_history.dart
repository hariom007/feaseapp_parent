import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Helper/helper.dart';
import 'package:parent_institute/Model/paymentHistory.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

class PaymentHistory extends StatefulWidget {
  final String studentId;
  PaymentHistory({Key key, this.studentId}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {


  bool isLoading = false;
  bool isLoaded = false;
  List<PaymentHistoryModel> _getPayment = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentHistoryList();
  }

  getPaymentHistoryList() async {

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "StudAcadID" : '${widget.studentId}'
      };
      print(data);
      var res = await CallApi().postData(data,"GetFeeDetailList");
      var body = json.decode(res.body);
      print(body);
          {
        List cartList = body as List;
        _getPayment = cartList.map<PaymentHistoryModel>((json) => PaymentHistoryModel.fromJson(json)).toList();


        setState(() {
          isLoading =false;
          isLoaded = true;
        });
      }

    } catch (exception) {
      print('$exception');
    }
  }


  getFeeReciept(String payID) async {
    Helper.dialogHelper.showAlertDialog(context);

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "payID" : payID
      };
      var res = await CallApi().postData(data,"GetFeeReceipt");
      var body = json.decode(res.body);
      // print(body);

      {
        var url = body['Url'];

        // var url = 'finaltestapi.acadmin.in/Files/201900009/116/FeesReceipt/10001.pdf';

        var  curl = 'https://';

        var turl =  curl + url;

        print(turl);
        Navigator.pop(context);

        await launchURL(turl);


      }

    } catch (exception) {
      print('$exception');
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body:  _getPayment !=null ? Builder(
        builder: (context){
          if(isLoaded==true)
          {
            if (_getPayment.isEmpty) {
              return Center(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            'Sorry ! No Payment History.',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),

                        ],
                      )));
            }
          }
          else{
            return Center (
              child: CircularProgressIndicator(),
            );
          }
          return  ListView.builder(
            shrinkWrap: true,
            itemCount: _getPayment.length,
            itemBuilder: (context,index){
              var sr = index+1;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                      Text(_getPayment[index].StudentName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      SizedBox(height: 2,),
                                      Row(
                                        children: [
                                          Text('Total Fee : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Expanded(
                                            child: Text(_getPayment[index].CoursetotalFees,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        children: [
                                          Text('Paid Fee : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Expanded(
                                            child: Text(_getPayment[index].paidFees,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        child: Container(
                                          width: width,
                                          child: RaisedButton.icon(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0)
                                            ),
                                            color: AppColors.appBarColor,
                                              onPressed: () async{
                                                getFeeReciept(_getPayment[index].payID);
                                              },
                                              icon: Icon(Icons.download_rounded,color: AppColors.white_00,),
                                              label: Text(
                                                'Download Reciept',style: TextStyle(
                                                color: AppColors.white_00,
                                                fontFamily: 'Montserrat-semibold'
                                              ),)
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),


                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        );
        },
      ) :Center(child: CircularProgressIndicator(),),
    );
  
  }
}
/*ListView.builder(
            shrinkWrap: true,
            itemCount: _getPayment.length,
            itemBuilder: (context,index){
              var sr = index+1;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                      Text(_getPayment[index].StudentName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      SizedBox(height: 2,),
                                      Row(
                                        children: [
                                          Text('Total Fee : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Expanded(
                                            child: Text(_getPayment[index].CoursetotalFees,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(
                                        children: [
                                          Text('Paid Fee : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Expanded(
                                            child: Text(_getPayment[index].paidFees,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        child: Container(
                                          width: width,
                                          child: RaisedButton.icon(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0)
                                            ),
                                            color: AppColors.appBarColor,
                                              onPressed: () async{
                                                getFeeReciept(_getPayment[index].payID);
                                              },
                                              icon: Icon(Icons.download_rounded,color: AppColors.white_00,),
                                              label: Text(
                                                'Download Reciept',style: TextStyle(
                                                color: AppColors.white_00,
                                                fontFamily: 'Montserrat-semibold'
                                              ),)
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),


                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )*/