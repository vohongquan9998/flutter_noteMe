import 'package:flutter/material.dart';
import 'package:flutter_note_app/src/editnote.dart';
import 'package:flutter_note_app/src/homepage.dart';
import 'package:flutter_note_app/widget/alertdialog.dart';
import 'package:flutter_note_app/widget/notecontroller.dart';
import 'package:flutter_note_app/widget/painterWidget.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final NoteControl control = Get.find();
  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.blue[300], Colors.blue[100]],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(6, 6),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GetBuilder<NoteControl>(
                      builder: (_) => Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SelectableText(
                                control.notes[i].title,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Thời gian chỉnh sửa cuối cùng : " +
                                    control.notes[i].dateTimeEdited,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SelectableText(
                                control.notes[i].content,
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: WidgetCustomPainter(),
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white70,
                            size: 35,
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FlatButton(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialogWidget(
                                                contentText:
                                                    "Bạn có muốn xoá nhắc nhở này",
                                                confimn: () {
                                                  control.deleteNote(
                                                      control.notes[i].id);
                                                  Get.offAll(HomePage());
                                                },
                                                decline: () {
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.delete,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        onPressed: () {
                                          control.shareNote(
                                            control.notes[i].title,
                                            control.notes[i].content,
                                            control.notes[i].dateTimeEdited,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.share,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Share',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Thời gian :" +
                                                  control
                                                      .notes[i].dateTimeCreated,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Chữ cái :" +
                                                  control.contentWordCount
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Kí tự :" +
                                                  control.contentCharCount
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.blue[100]);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                backgroundColor: Colors.blue[300],
                child: Icon(Icons.edit),
                onPressed: () {
                  Get.to(
                    EditNote(),
                    arguments: i,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
