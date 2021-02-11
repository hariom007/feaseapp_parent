import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/paymentFailed.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/paymentSuccess.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'razorpay_flutter.dart';

class CheckRazor extends StatefulWidget {
  final String amt,mobile,email,API_KEY,API_SECRET,stuId;
  List installList;
  CheckRazor({Key key,this.amt,this.mobile,this.email,this.API_KEY,this.API_SECRET,this.stuId,this.installList}) : super(key:key);
  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  Razorpay _razorpay = Razorpay();
  var options,optionss;
  String txnID = "";

  Future payData() async {
    txnID = randomAlphaNumeric(20);
    optionss = {
      "amount": '${widget.amt}',
      "currency": "INR",
      "receipt": txnID,
      "payment_capture": 1,
    };
    try {
      var res = await CallApi().razorPaypostData('${widget.API_KEY}','${widget.API_SECRET}',optionss, 'orders');
      var body = json.decode(res.body);
      print(body);

      if(body['id'] != null){

        options = {
          'key': '${widget.API_KEY}', // Enter the Key ID generated from the Dashboard

          'amount': '${widget.amt}', //in the smallest currency sub-unit.
          'name': 'Fees Of Your Child',
          'order_id': body['id'],
          'currency': "INR",
          'buttontext': "Pay with Razorpay",
          'description': '.....',
          'prefill': {
            'contact': '${widget.mobile}',
            'email': '${widget.email}',
          }
        };
        _razorpay.open(options);
      }

    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    print("payment has succedded");
    print(txnID);
    String minAmount = '${widget.amt}';
    double iminAmount = double.parse(minAmount)/100;
    String actualAmount = iminAmount.toString();
    var data = {
      "StudAcadID" : '${widget.stuId}',
      "razorpay_order_id" : response.orderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": response.signature,
      "amount" : actualAmount,
      "InstallmentList" : widget.installList
    };
    var res = await CallApi().postData(data, 'OnlinePaymentRazorPay');
    var body = json.decode(res.body);
    print(body);
    //print(response);*/
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
              response: response,
            ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
              response: response,
            ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
