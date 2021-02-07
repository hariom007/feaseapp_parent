import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<PaymentGatewaykeysModel> PaymentGatewaykeysModelModelListFromJson(String str) =>
    List<PaymentGatewaykeysModel>.from(json.decode(str).map((x) => PaymentGatewaykeysModel.fromJson(x)));

String PaymentGatewaykeysModelListToJson(List<PaymentGatewaykeysModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentGatewaykeysModel{
  String PGatewayType;
  String WorkingKey;
  String AccessCode;

  PaymentGatewaykeysModel({
    this.PGatewayType,
    this.WorkingKey,
    this.AccessCode,

  });

  factory PaymentGatewaykeysModel.fromJson(Map<String, dynamic> json) {
    return PaymentGatewaykeysModel(
      PGatewayType: json['PGatewayType'],
      WorkingKey: json['WorkingKey'],
      AccessCode: json['AccessCode'],

    );}

  Map<String,dynamic> toJson() => {
    'PGatewayType' : PGatewayType,
    'WorkingKey' : WorkingKey,
    'AccessCode' : AccessCode,
  };
}