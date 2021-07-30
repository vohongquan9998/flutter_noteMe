import 'package:flutter/material.dart';
import 'package:flutter_note_app/widget/notecontroller.dart';
import 'package:flutter_note_app/widget/painterWidget.dart';
import 'package:get/get.dart';

class EditNote extends StatelessWidget {
  final NoteControl control = Get.find();
  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context).settings.arguments;
    control.titleController.text = control.notes[i].title;
    control.contentController.text = control.notes[i].content;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 60,
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
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    children: [
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.save),
        onPressed: () {
          control.updateNote(
              control.notes[i].id, control.notes[i].dateTimeCreated);
        },
      ),
    );
  }
}
