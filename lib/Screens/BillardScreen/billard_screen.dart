import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Welcome/main_welcome.dart';

class BillardScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BillardScreen> {
  Box? boxNames;
  var allNames;

  readData() {
    boxNames = Hive.box("names");
    allNames = boxNames?.toMap();
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.w, top: 30.h),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => MainWelcomeScreen()),
                        (Route<dynamic> route) => false);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 24.r,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text(
              'List Player',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),
            child: TextField(
              maxLength: 25,
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Player Name',
                counterText: '',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(fontSize: 14.sp),
              ),
              onPressed: () {
                boxNames?.add([nameController.text, "Not Paid"]);
                setState(() {
                  readData();
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: allNames?.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                "${i + 1} - ${allNames.values.toList()[i][0]}  (${allNames.values.toList()[i][1]})"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (allNames.values.toList()[i][1] ==
                                        'Not Paid') {
                                      boxNames?.put(allNames.keys.toList()[i], [
                                        allNames.values.toList()[i][0],
                                        "Paid"
                                      ]);
                                      setState(() {
                                        readData();
                                        // names;
                                      });
                                    } else if (allNames.values.toList()[i][1] ==
                                        'Paid') {
                                      boxNames?.put(allNames.keys.toList()[i], [
                                        allNames.values.toList()[i][0],
                                        "Not Paid"
                                      ]);
                                      setState(() {
                                        readData();
                                        // names;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    boxNames?.delete(allNames.keys.toList()[i]);
                                    setState(() {
                                      readData();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
