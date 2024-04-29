import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:notedo_app/json/todo_list_model.dart';
import 'package:notedo_app/widgets/custom_button.dart';
import 'package:notedo_app/widgets/dialog_addtodo.dart';
import 'package:notedo_app/widgets/item_siidable.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.isWhiteMode,
    this.hasAppBar = false,
    this.title = '',
  });

  final bool isWhiteMode;
  final String title;
  final bool hasAppBar;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _mycontroller = TextEditingController();
  bool isChecked = false;
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
        key: const PageStorageKey('todos'),
        padding:
            const EdgeInsets.only(top: 32, bottom: 120, left: 20, right: 20),
        itemCount: todoTasksList.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 6,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            editTaskMethod(index);
            isChecked = todoTasksList[index][2];
          },
          child: NoteAndTodoItemCardSlidable(
            noteTitle: todoTasksList[index][0],
            hasContent: false,
            date: todoTasksList[index][1],
            deleteNoteMethod: (context) => deleteNoteMethod(index),
            isWhiteMode: widget.isWhiteMode,
            noteContent: '',
            leading: true,
            isCecked: todoTasksList[index][2],
            onChanged: (value) => checkBoxSelected(value, index),
          ),
        ),
      ),
    );
  }

  void checkBoxSelected(bool? value, int index) {
    setState(() {
      todoTasksList[index][2] = !todoTasksList[index][2];
    });
  }

  void editTaskMethod(int index) {
    _mycontroller.text = todoTasksList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoTaskDialog(
          mycontroller: _mycontroller,
          onSave: () {
            setState(() {
              String updatedTask = _mycontroller.text;

              todoTasksList.removeAt(index);
              todoTasksList.insert(0, [updatedTask, DateTime.now(), isChecked]);
            });
            _mycontroller.clear();
            Navigator.pop(context);
          },
          isWhiteMode: widget.isWhiteMode,
        );
      },
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
                          todoTasksList.removeAt(index);
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
