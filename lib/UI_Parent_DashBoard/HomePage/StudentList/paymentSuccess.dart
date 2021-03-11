import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Helper/helper.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/razorpay_flutter.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessPage extends StatefulWidget {

  final PaymentSuccessResponse response;
  final String payID;
  SuccessPage({@required this.response, this.payID});

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool isLoading = true;

  getFeeReciept(BuildContext bcontext) async {
    Helper.dialogHelper.showAlertDialog(bcontext);

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "payID" : '${widget.payID}'
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
        Navigator.pop(bcontext);

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 5),
              child: RaisedButton.icon(
                  color: AppColors.white_00,

                  icon: Icon(Icons.download_rounded,color: AppColors.black,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  label: Text('Download Reciept',
                    style: TextStyle(
                        fontFamily: 'Montserrat-semibold',
                        color: AppColors.black,
                        fontSize: 12
                    ),),
                  onPressed: (){
                    getFeeReciept(context);
                  }
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Icon(Icons.check_circle_outline,
                color: AppColors.red_00,
                size: 100,),
              SizedBox(height: 10,),
              Text('Payment Successful',
              style: TextStyle(
                fontSize: 20
              ),),
              SizedBox(height: 10,),
              Text('Your payment has been processed!\n'
                  'Details of the transaction has been included below',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12
                ),),
              SizedBox(height: 30,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                color: AppColors.white_20,
                elevation: 05,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order Id :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                  SizedBox(height: 3,),
                                  Text('Transaction Id :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),

                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${widget.response.orderId}'),
                                      SizedBox(height: 3,),
                                      Text('${widget.response.paymentId}'),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.appButtonColor,
                onPressed: (){
                 MyParentNavigator.goToKillDashBoard(context);
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: 'Montserrat-regular',
                        color: AppColors.white_00,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Go To HomePage '
                      ),
                      WidgetSpan(
                        child: Icon(Icons.arrow_forward,color: AppColors.white_00,
                        size: 20,)
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


