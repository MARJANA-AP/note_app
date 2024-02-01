import 'package:flutter/material.dart';
import 'package:note_app/colorTheme/colorpalette.dart';
import 'package:note_app/colorTheme/colorProvider.dart';
import 'package:note_app/firebase/firebaseservice.dart';
import 'package:provider/provider.dart';

import '../colorTheme/colorpicker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FirestoreService fbService = FirestoreService();

  @override
  void initState() {
    Provider.of<ColorProvider>(context, listen: false).setindextoZero();
    super.initState(); //initial background color transparent
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ColorProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: bgColor[themeData.selectedIndex],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Title:",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  controller: titleController,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  decoration: const InputDecoration(hintText: "Description"),
                  controller: descriptionController,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ColorPicker(themeData: themeData);
                        });
                  },
                  child: Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text("Color"),
                      )))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final String title = titleController.text;
          final String desc = descriptionController.text;

          fbService.addNotebasedUser(title, desc, themeData.selectedIndex);
          titleController.clear();
          descriptionController.clear();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
