import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../credit_screen.dart';

class EditPersonScreen extends StatefulWidget {
  final String oldName;
  final String oldAmount;
  final String oldDate;
  final int id;
  // final Function refreshFun;
  EditPersonScreen(
      {Key? key,
      // required this.refreshFun,
      required this.oldName,
      required this.oldAmount,
      required this.oldDate,
      required this.id})
      : super(key: key);

  @override
  State<EditPersonScreen> createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends State<EditPersonScreen> {
  Box? box = Hive.box("credit");
  late TextEditingController nameController =
      TextEditingController(text: widget.oldName);
  late TextEditingController amountController =
      TextEditingController(text: widget.oldAmount);
  late TextEditingController dateController =
      TextEditingController(text: widget.oldDate);

  datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((Date) {
      setState(() {
        String newDate = Date.toString().substring(0, 10);
        dateController.text = newDate.split('-').reversed.join('/');
      });
    });
  }

  static final _forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Hive.openBox('pespost');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit person'),
          backgroundColor: Color.fromRGBO(36, 36, 36, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              key: _forKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: nameController,
                      maxLength: 25,
                      decoration: const InputDecoration(
                          hintText: "Name", counterText: ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: "Amount"),
                      validator: (value) {
                        try {
                          int.parse(value!);
                          return null;
                        } catch (e) {
                          return 'Please enter Correct number';
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          width: size.width * 0.85,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: dateController,
                            decoration: const InputDecoration(hintText: "Date"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            datePicker();
                          },
                          child: Container(
                            height: 50,
                            width: 20,
                            child: Icon(
                              Icons.calendar_month_rounded,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(36, 36, 36, 1),
                    ),
                    onPressed: () {
                      if (_forKey.currentState!.validate()) {
                        box?.put(widget.id, [
                          nameController.text,
                          amountController.text,
                          dateController.text
                        ]);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CreditScreen()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Text("Edit Person"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 253, 47, 47),
                    ),
                    onPressed: () {
                      if (_forKey.currentState!.validate()) {
                        box?.delete(widget.id);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CreditScreen()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Text("Delet Person"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
