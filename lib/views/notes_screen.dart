import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:notedo_app/models/note_model.dart';
import 'package:notedo_app/views/edit_note_screen.dart';
import 'package:notedo_app/widgets/custom_button.dart';
import 'package:notedo_app/widgets/item_siidable.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    super.key,
    required this.isWhiteMode,
    this.hasAppBar = false,
    this.title = '',
  });

  final bool isWhiteMode;
  final String title;
  final bool hasAppBar;

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hasAppBar
          ? AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(widget.title),
            )
          : null,
      body: ListView.separated(
        key: const PageStorageKey('notes'),
        padding:
            const EdgeInsets.only(top: 32, bottom: 120, left: 20, right: 20),
        itemCount: notesList.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 6,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            final noteContent = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EditNoteScreen(
                  isWhiteMode: widget.isWhiteMode,
                  noteCardModel: notesList[index],
                );
              }),
            );
            if (noteContent != null) {
              setState(() {
                int originalIndex = notesList.indexOf(notesList[index]);
                notesList.removeAt(originalIndex);

                notesList.insert(
                    0,
                    NoteCardModel(
                      title: noteContent[0],
                      content: noteContent[1],
                      date: DateTime.now(),
                      id: notesList.length,
                      hasContent: true,
                    ));
              });
            }
          },
          child: NoteAndTodoItemCardSlidable(
            noteTitle: notesList[index].title,
            noteContent: notesList[index].content,
            hasContent: notesList[index].hasContent,
            date: notesList[index].date,
            deleteNoteMethod: (context) => deleteNoteMethod(index),
            isWhiteMode: widget.isWhiteMode,
            onChanged: null,
          ),
        ),
      ),
    );
  }

  void deleteNoteMethod(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Ionicons.ios_alert_circle,
                size: 50, color: Colors.red),
            title: const Text(
              'Delete Alert',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to delete this Note?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyCustomElevatedButton(
                      onPresssed: () {
                        setState(() {
                          notesList.removeAt(index);
                        });
                        Navigator.pop(context, true);
                      },
                      label: 'Delete',
                      btnColor: Colors.red,
                    ),
                    MyCustomElevatedButton(
                      onPresssed: () => Navigator.pop(context),
                      label: 'Cancle',
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
