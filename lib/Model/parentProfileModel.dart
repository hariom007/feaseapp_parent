import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<ParentProfileModel> ParentProfileModelModelListFromJson(String str) =>
    List<ParentProfileModel>.from(json.decode(str).map((x) => ParentProfileModel.fromJson(x)));

String ParentProfileModelListToJson(List<ParentProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentProfileModel{
  String FatherName;
  String MotherName;
  String MobileNo;
  String EmailID;
  String Address;
  String FatherImage;
  String MotherImage;

  ParentProfileModel({
    this.FatherName,
    this.MotherName,
    this.MobileNo,
    this.EmailID,
    this.Address,
    this.FatherImage,
    this.MotherImage,

  });

  factory ParentProfileModel.fromJson(Map<String, dynamic> json) {
    return ParentProfileModel(
      FatherName: json['FatherName'],
      MotherName: json['MotherName'],
      MobileNo: json['MobileNo'],
      EmailID: json['EmailID'],
      Address: json['Address'],
      FatherImage: json['FatherImage'],
      MotherImage: json['MotherImage'],

    );}

  Map<String,dynamic> toJson() => {
    'FatherName' : FatherName,
    'MotherName' : MotherName,
    'MobileNo' : MobileNo,
    'EmailID' : EmailID,
    'Address' : Address,
    'FatherImage' : FatherImage,
    'MotherImage' : MotherImage,

  };
}