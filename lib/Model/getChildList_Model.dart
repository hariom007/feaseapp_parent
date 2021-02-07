import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<GetChildListModel> GetChildListModelModelListFromJson(String str) =>
    List<GetChildListModel>.from(json.decode(str).map((x) => GetChildListModel.fromJson(x)));

String GetChildListModelListToJson(List<GetChildListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChildListModel{
  String FullName;
  String ClassName;
  String RollNo;
  String StudAcadID;

  GetChildListModel({
    this.FullName,
    this.ClassName,
    this.RollNo,
    this.StudAcadID,

  });

  factory GetChildListModel.fromJson(Map<String, dynamic> json) {
    return GetChildListModel(
      FullName: json['FullName'],
      ClassName: json['ClassName'],
      RollNo: json['RollNo'],
      StudAcadID: json['StudAcadID'],

    );}

  Map<String,dynamic> toJson() => {
    'FullName' : FullName,
    'ClassName' : ClassName,
    'RollNo' : RollNo,
    'StudAcadID' : StudAcadID,

  };
}