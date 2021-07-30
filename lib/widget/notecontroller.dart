import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/models/notes.dart';
import 'package:flutter_note_app/services/db.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';
import 'package:get/get.dart';

class NoteControl extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var notes = List<Note>();
  int contentWordCount = 0;
  int contentCharCount = 0;

  @override
  void onInit() {
    getDataNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.length == 0)
      return true;
    else
      return false;
  }

  void insertNoteToDb() async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isNullOrBlank) {
      title = "Nhắc nhở chưa đặt tên";
    }
    Note note = Note(
      title: title,
      content: content,
      dateTimeEdited:
          DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeCreated:
          DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
    );
    await DatabaseHelper.instance.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getDataNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(
      id: id,
    );
    await DatabaseHelper.instance.deleteNote(note);
    getDataNotes();
  }

  void deleteAllNote() async {
    await DatabaseHelper.instance.deleteAllofNote();
    getDataNotes();
  }

  void updateNote(int id, String dTCreated) async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeEdited:
          DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getDataNotes();
    Get.back();
  }

  void getDataNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    update();
  }

  void shareNote(String title, String content, String dateTimeEdited) {
    Share.share("$title \n\n$dateTimeEdited\n\n$content");
  }
}
