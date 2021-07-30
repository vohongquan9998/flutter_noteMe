import 'package:flutter/material.dart';
import 'package:flutter_note_app/src/note_detail.dart';
import 'package:flutter_note_app/widget/notecontroller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchTool extends SearchDelegate {
  final NoteControl control = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          color: Colors.blue[200],
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.blue[200],
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestList = query.isEmpty
        ? control.notes
        : control.notes.where(
            (p) {
              return p.title.toLowerCase().contains(query.toLowerCase()) ||
                  p.content.toLowerCase().contains(query.toLowerCase());
            },
          ).toList();
    return Container(
      color: Colors.blue[50],
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: suggestList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                DetailPage(),
                arguments: index,
              );
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[200], Colors.blue[100]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    suggestList[index].title,
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
                    suggestList[index].content,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(control.notes[index].dateTimeEdited),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.6);
        },
      ),
    );
  }
}
