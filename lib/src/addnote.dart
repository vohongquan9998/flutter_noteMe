import 'package:flutter/material.dart';
import 'package:flutter_note_app/widget/notecontroller.dart';
import 'package:flutter_note_app/widget/painterWidget.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final NoteControl control = Get.find();

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  onHover: (hoving) {
                    if (hoving)
                      setState(() {
                        isHover = true;
                      });
                    else
                      setState(() {
                        isHover = false;
                      });
                  },
                  child: Container(
                    height: 50,
                    width: isHover ? 100 : 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      color: Colors.white60,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: control.titleController,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  cursorColor: Colors.blue[700],
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.category,
                      size: 30,
                      color: Colors.blue[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Tiêu đề',
                    labelStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: control.contentController,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    cursorColor: Colors.blue[700],
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.text_fields,
                        size: 22,
                        color: Colors.blue[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'Nội dung',
                      labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Stack(children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: WidgetCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: Colors.blue[300],
              child: Icon(Icons.check),
              onPressed: () {
                control.insertNoteToDb();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
