import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<StudentListForPaymentModel> StudentListForPaymentModelModelListFromJson(String str) =>
    List<StudentListForPaymentModel>.from(json.decode(str).map((x) => StudentListForPaymentModel.fromJson(x)));

String StudentListForPaymentModelListToJson(List<StudentListForPaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentListForPaymentModel{
  String FullName;
  String Course;
  String StudAcadID;
  String TotalFees;
  String PaidAmount;
  String BalAmount;

  StudentListForPaymentModel({
    this.FullName,
    this.Course,
    this.StudAcadID,
    this.TotalFees,
    this.PaidAmount,
    this.BalAmount,

  });

  factory StudentListForPaymentModel.fromJson(Map<String, dynamic> json) {

    return StudentListForPaymentModel(
      FullName: json['FullName'],
      Course: json['Course'],
      StudAcadID: json['StudAcadID'],
      TotalFees: json['TotalFees'],
      PaidAmount: json['PaidAmount'],
      BalAmount: json['BalAmount'],

    );}

  Map<String,dynamic> toJson() => {
    'FullName' : FullName,
    'Course' : Course,
    'StudAcadID' : StudAcadID,
    'TotalFees' : TotalFees,
    'PaidAmount' : PaidAmount,
    'BalAmount' : BalAmount,

  };
}