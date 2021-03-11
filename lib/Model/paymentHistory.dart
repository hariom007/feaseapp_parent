import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<PaymentHistoryModel> PaymentHistoryModelModelListFromJson(String str) =>
    List<PaymentHistoryModel>.from(json.decode(str).map((x) => PaymentHistoryModel.fromJson(x)));

String PaymentHistoryModelListToJson(List<PaymentHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentHistoryModel{
  String StudentName;
  String Coursedtls;
  String CoursetotalFees;
  String paidFees;
  String ReceiptDate;
  String payID;

  PaymentHistoryModel({
    this.StudentName,
    this.Coursedtls,
    this.CoursetotalFees,
    this.paidFees,
    this.ReceiptDate,
    this.payID,

  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      StudentName: json['StudentName'],
      Coursedtls: json['Coursedtls'],
      CoursetotalFees: json['CoursetotalFees'],
      paidFees: json['paidFees'],
      ReceiptDate: json['ReceiptDate'],
      payID: json['payID'],

    );}

  Map<String,dynamic> toJson() => {
    'StudentName' : StudentName,
    'Coursedtls' : Coursedtls,
    'CoursetotalFees' : CoursetotalFees,
    'paidFees' : paidFees,
    'ReceiptDate' : ReceiptDate,
    'payID' : payID,

  };
}