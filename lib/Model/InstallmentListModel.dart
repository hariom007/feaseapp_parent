import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<InstallmentListModel> InstallmentListModelModelListFromJson(String str) =>
    List<InstallmentListModel>.from(json.decode(str).map((x) => InstallmentListModel.fromJson(x)));

String InstallmentListModelListToJson(List<InstallmentListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InstallmentListModel{
  String Installid;
  String Installment;
  String hiddInstallment;
  String InstallmentAmount;
  bool Chk;

  InstallmentListModel({
    this.Installid,
    this.Installment,
    this.hiddInstallment,
    this.InstallmentAmount,
    this.Chk,

  });

  factory InstallmentListModel.fromJson(Map<String, dynamic> json) {
    return InstallmentListModel(
      Installid: json['Installid'],
      Installment: json['Installment'],
      hiddInstallment: json['hiddInstallment'],
      InstallmentAmount: json['InstallmentAmount'],
      Chk: json['Chk'],

    );}

  Map<String,dynamic> toJson() => {
    'Installid' : Installid,
    'Installment' : Installment,
    'hiddInstallment' : hiddInstallment,
    'InstallmentAmount' : InstallmentAmount,
    'Chk' : Chk,

  };
}