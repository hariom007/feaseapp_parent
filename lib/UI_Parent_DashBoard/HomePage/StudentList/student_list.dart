import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parent_institute/API/api.dart';
import 'package:parent_institute/Model/getChildList_Model.dart';
import 'package:parent_institute/UI_Parent_DashBoard/HomePage/StudentList/getStudentDetails.dart';
import 'package:parent_institute/Values/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  bool isLoading = false;
  bool isLoaded = false;
  List<GetChildListModel> _getChild = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChildList();
  }
  getChildList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String mob = sharedPreferences.getString('MOB');

    try {
      setState(() {
        isLoading =true;
      });

      var data ={
        "MobileNo" : mob
      };
      var res = await CallApi().postData(data,"getChildList");
      var body = json.decode(res.body);
      // print(body);
          {
        List cartList = body as List;
        _getChild = cartList.map<GetChildListModel>((json) => GetChildListModel.fromJson(json)).toList();


        setState(() {
          isLoading =false;
          isLoaded = true;
        });
      }

    } catch (exception) {
      print('$exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Student List'),
      ),
      body:isLoaded ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _getChild.length,
            itemBuilder: (context,index){
              var sr = index+1;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GetStudentDetail(
                      studentId: _getChild[index].StudAcadID,)));
                    // _getChild.clear();
                  },
                  child: Card(
                    color: AppColors.white_10,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8,right: 8),
                                  child: Text(sr.toString()+'.',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_getChild[index].FullName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        SizedBox(height: 2,),
                                        Row(
                                          children: [
                                            Text('Student Id : ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            Expanded(
                                              child: Text(_getChild[index].StudAcadID,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Row(
                                          children: [
                                            Text('Class : ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            Expanded(
                                              child: Text(_getChild[index].ClassName,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Row(
                                          children: [
                                            Text('Roll no. : ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            Expanded(
                                              child: Text(_getChild[index].RollNo,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                                /*CircleAvatar(
                                          radius: 30,
                                          child:  Image.asset('assets/icon/as.png'),
                                        ),*/
                              ],
                            ),
                            SizedBox(height: 10,),
                            /*Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Pending Fee : ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        SizedBox(width: 5,),
                                        Text('25000',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Image.asset('assets/icon/rupee.png',height: 15),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: RaisedButton(
                                            color: AppColors.appBarColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)
                                            ),

                                            child: Text('Pay Now',style: TextStyle(
                                                color: AppColors.white_00,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat-SemiBold'
                                            ),),
                                            onPressed: () {
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                                            },
                                          ),
                                        )
                                      ],
                                    ),*/


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ):
      Center(child: CircularProgressIndicator(),),
    );
  }
}
