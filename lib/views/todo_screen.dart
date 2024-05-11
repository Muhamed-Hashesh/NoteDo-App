import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';
import 'package:notedo_app/controllers/todo_controller.dart';
import 'package:notedo_app/widgets/custom_button.dart';
import 'package:notedo_app/widgets/dialog_addtodo.dart';
import 'package:notedo_app/widgets/item_siidable.dart';

class TodoScreen extends GetView<TodoController> {
  const TodoScreen({
    Key? key,
    this.hasAppBar = false,
    this.title = '',
  }) : super(key: key);

  final String title;
  final bool hasAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(title),
            )
          : null,
      body: Obx(
        () => ListView.separated(
          key: const PageStorageKey('todos'),
          padding:
              const EdgeInsets.only(top: 32, bottom: 120, left: 20, right: 20),
          itemCount: controller.todosList.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 6,
          ),
          itemBuilder: (context, index) {
            final todo = controller.todosList[index];
            return GestureDetector(
              onTap: () {
                // Set isChecked value before showing the dialog
                controller.isChecked.value = todo.isCompleted;
                editTaskMethod(context, index);
              },
              child: NoteAndTodoItemCardSlidable(
                noteTitle: todo.title,
                hasContent: false,
                date: todo.date,
                deleteNoteMethod: (context) => deleteNoteMethod(context, index),
                noteContent: '',
                leading: true,
                isCecked: todo.isCompleted,
                onChanged: (value) => controller.checkBoxSelected(value, index),
              ),
            );
          },
        ),
      ),
    );
  }

  void editTaskMethod(BuildContext context, int index) {
    controller.mycontroller.text = controller.todosList[index].title;
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoTaskDialog(
          mycontroller: controller.mycontroller,
          isChecked: controller.isChecked.value,
          onSave: () {
            String updatedTask = controller.mycontroller.text;
            controller.updateTodo(
              index,
              updatedTask,
              DateTime.now(),
              controller.isChecked.value,
            );
            controller.mycontroller.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void deleteNoteMethod(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Ionicons.ios_alert_circle,
            size: 50,
            color: Colors.red,
          ),
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
                      controller.deleteTodo(controller.todosList[index].id);
                      controller.todosList.removeAt(index);
                      Navigator.pop(context, true);
                    },
                    label: 'Delete',
                    btnColor: Colors.red,
                  ),
                  MyCustomElevatedButton(
                    onPresssed: () => Navigator.pop(context),
                    label: 'Cancel',
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
