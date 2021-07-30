import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/src/addnote.dart';
import 'package:flutter_note_app/src/note_detail.dart';
import 'package:flutter_note_app/widget/alertdialog.dart';
import 'package:flutter_note_app/widget/clipppathItem.dart';
import 'package:flutter_note_app/widget/notecontroller.dart';
import 'package:flutter_note_app/widget/painterWidget.dart';
import 'package:flutter_note_app/widget/search.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteControl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: GetBuilder<NoteControl>(
          builder: (_) => controller.isEmpty() ? emptyNote() : viewNotes(),
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
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                backgroundColor: Colors.blue[300],
                child: Icon(Icons.add),
                onPressed: () {
                  Get.to(AddNote());
                },
              ),
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      hoverColor: Colors.white60,
                      icon: Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        showSearch(context: context, delegate: SearchTool());
                      }),
                  IconButton(
                      hoverColor: Colors.white60,
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white70,
                        size: 35,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogWidget(
                              contentText:
                                  'Bạn có chắc muốn xoá tất cả lời nhắc',
                              confimn: () {
                                controller.deleteAllNote();
                                Get.back();
                              },
                              decline: () {
                                Get.back();
                              },
                            );
                          },
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.6);
          },
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  DetailPage(),
                  arguments: index,
                );
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogWidget(
                        contentText: "Bạn có muốn xoá lời nhắc này không?",
                        confimn: () {
                          controller.deleteNote(controller.notes[index].id);
                          Get.back();
                        },
                        decline: () {
                          Get.back();
                        },
                      );
                    });
              },
              child: ClipPath(
                clipper: ClipPathNoteWidget(),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[200], Colors.blue[100]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.notes[index].title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.notes[index].content,
                        maxLines: 6,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(controller.notes[index].dateTimeEdited)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget emptyNote() {
    return Container(
      child: Center(
        child: Text(
          'Bạn không có lời nhắn nào cả',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900].withOpacity(.7)),
        ),
      ),
    );
  }
}
