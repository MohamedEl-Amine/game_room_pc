import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../pes_screen.dart';

class EditPostScreen extends StatefulWidget {
  final id;
  final oldname;
  final oldnumber;
  EditPostScreen(
      {Key? key,
      required this.id,
      required this.oldname,
      required this.oldnumber})
      : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  Box? box = Hive.box("pespost");
  late TextEditingController nameController =
      TextEditingController(text: widget.oldname);
  TextEditingController timeController = TextEditingController();

  Future readData() async {
    await Hive.openBox('pespost');
    box;
  }

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Post'),
          backgroundColor: Color.fromRGBO(47, 143, 157, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(47, 143, 157, 1)),
                    onPressed: () {
                      box?.put(
                          widget.id, [nameController.text, widget.oldnumber]);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PesScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Edit Post"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(47, 143, 157, 1)),
                    onPressed: () {
                      box?.delete(widget.id);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PesScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Delete Post"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
