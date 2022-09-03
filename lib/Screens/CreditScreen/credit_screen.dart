// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_room/Welcome/main_welcome.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'AddAndEdit/add_person.dart';
import 'AddAndEdit/edit_person.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  List credit = [];
  num totalCredit = 0;

  CalculatCredit() {
    num totalCredit = 0;
    for (var i in credit) {
      setState(() {
        totalCredit += int.parse(i[1]);
      });
    }
    return totalCredit;
  }

  Box? creditNames;
  var allCredit;

  readData() {
    creditNames = Hive.box("credit");
    allCredit = creditNames?.toMap();
    credit = allCredit.values.toList();
  }

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox('credit');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.r, top: 50.r, right: 20.r),
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => MainWelcomeScreen()),
                                (Route<dynamic> route) => false);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25.r,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Credit",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddPersonScreen()),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            size: 36.r,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 5.h),
                    child: Text(
                      "Total of Person : ${allCredit.length}",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                  Text(
                    "Total of Credit : ${CalculatCredit()} DA",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.r, left: 20.r, right: 20.r),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: allCredit.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 100.r,
                            margin: EdgeInsets.only(bottom: 20.r),
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image:
                              //         AssetImage("icons/backgroundCredit.png"),
                              //     fit: BoxFit.fill),
                              color: Color.fromRGBO(36, 36, 36, 1),
                              border: Border.all(width: 1.r),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15.r),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      height: 50.r,
                                      width: 50.r,
                                      child: Image.asset(
                                        "icons/user.png",
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      child: Text(
                                        '${allCredit.values.toList()[i][0]}',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      '${allCredit.values.toList()[i][1]} DA',
                                      style: TextStyle(
                                          fontSize: 25.sp, color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      height: 20.r,
                                      width: 20.r,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPersonScreen(
                                                // refreshFun: refresh(),
                                                oldAmount: allCredit.values
                                                    .toList()[i][1],
                                                oldName: allCredit.values
                                                    .toList()[i][0],
                                                oldDate: allCredit.values
                                                    .toList()[i][2],
                                                id: allCredit.keys.toList()[i],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Image.asset(
                                            "icons/edit.png",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.r,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.r,
                                    ),
                                    Text(
                                      'Date of Creation : ${allCredit.values.toList()[i][2]}',
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
