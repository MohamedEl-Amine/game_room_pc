import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../pes_screen.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController nameController = TextEditingController();

  Future readData() async {
    await Hive.openBox('pespost');
  }

  @override
  void initState() {
    readData();
  }

  Box? box = Hive.box("pespost");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new Post'),
          backgroundColor: Color.fromRGBO(47, 143, 157, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: nameController,
                      maxLength: 25,
                      decoration: const InputDecoration(
                          hintText: "Name", counterText: ''),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(47, 143, 157, 1)),
                    onPressed: () {
                      box?.add([nameController.text, '0']);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PesScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Add Post"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
