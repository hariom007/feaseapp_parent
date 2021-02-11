import 'package:flutter/material.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/razorpay_flutter.dart';
import 'package:parent_institute/Values/AppColors.dart';

class SuccessPage extends StatelessWidget {
  final PaymentSuccessResponse response;
  SuccessPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
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
                                      Text('${response.orderId}'),
                                      SizedBox(height: 3,),
                                      Text('${response.paymentId}'),
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


