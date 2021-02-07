import 'package:flutter/material.dart';
import 'package:parent_institute/MyParentNavigator/myParentNavigator.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/razorpay_flutter.dart';
import 'package:parent_institute/Values/AppColors.dart';

class FailedPage extends StatelessWidget {
  final PaymentFailureResponse response;
  FailedPage({
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
          title: Text("Payment failed"),
        ),
        body:  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.red_00,
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: AppColors.white_00,
                  child: Icon(Icons.clear,
                  color: AppColors.red_00,
                  size: 100,),
                ),
              ),
              SizedBox(height: 10,),
              Text('Payment Failed',
                style: TextStyle(
                    fontSize: 20
                ),),
              SizedBox(height: 10,),
              Text('Your payment has been cancelled!\n'
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
                                  Text('Responce code :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                  SizedBox(height: 3,),
                                  Text('Message :',
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
                                      Text('${response.code}'),
                                      SizedBox(height: 3,),
                                      Text('${response.message}'),
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
                 // MyParentNavigator.goToDashboard(context);
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


