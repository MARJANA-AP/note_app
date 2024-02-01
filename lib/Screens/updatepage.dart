import 'package:flutter/material.dart';
import 'package:note_app/colorTheme/colorProvider.dart';
import 'package:note_app/colorTheme/colorpicker.dart';
import 'package:provider/provider.dart';

import '../colorTheme/colorpalette.dart';
import '../firebase/firebaseservice.dart';

class UpdatePage extends StatefulWidget {
  final dynamic id;
  final String txt;
  final String desc;
  final int currentcolor;
  const UpdatePage({
    super.key,
    required this.txt,
    required this.id,
    required this.desc,
    required this.currentcolor,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  FirestoreService fbserve = FirestoreService();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.txt);
    TextEditingController descriptionController =
        TextEditingController(text: widget.desc);
    //view content in updATE page textfield to update

    final themeData = Provider.of<ColorProvider>(context, listen: true);
    var newColor;
    newColor = themeData.isSelected
        ? bgColor[themeData.selectedIndex]
        : bgColor[widget.currentcolor];
    return Scaffold(
      backgroundColor: newColor,
      appBar: AppBar(
        backgroundColor: newColor,
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Title",
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
          final nid = widget.id;
          final String title = titleController.text;
          final String ds = descriptionController.text;
          fbserve.updateData(nid, title, ds, themeData.selectedIndex);
          Navigator.of(context).pop();
        },
        child: const Text("update"),
      ),
    );
  }
}
