import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notedo_app/database/notetodo_DB.dart';
import 'package:notedo_app/models/todo_model.dart';

class TodoController extends GetxController {
  final NoteTodoDB _db = NoteTodoDB();
  var todosList = <TodoCardModel>[].obs;
  final TextEditingController mycontroller =
      TextEditingController(); // Define mycontroller
  var isChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial todo list when the controller is initialized
    fetchTodos();
  }

  // Fetch all todos from the database
  void fetchTodos() async {
    try {
      final List<Map<String, dynamic>> todosData = await _db.readTodo();
      todosList.value =
          todosData.map((todoMap) => TodoCardModel.fromMap(todoMap)).toList();
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }

  // Add a new todo to the database and update the local list
  void addTodo(String title, DateTime date, bool isCompleted) async {
    try {
      final int id = await _db.insertTodo(title, date, isCompleted);
      final newTodo = TodoCardModel(
        title: title,
        date: date,
        id: id,
        isCompleted: isCompleted,
      );
      todosList.add(newTodo);
    } catch (e) {
      print('Error adding todo: $e');
    }
  }

  // Update an existing todo in the database and update the local list
  void updateTodo(int index, String title,DateTime date,
      bool isCompleted) async {
    final updatedToDo = TodoCardModel(
      title: title,
      date: date,
      id: todosList[index].id,
      isCompleted: isCompleted,
    );

    await _db.updateTodo(
      updatedToDo.id,
      updatedToDo.title,
      updatedToDo.date,
      updatedToDo.isCompleted,
    );

    // notesList.removeAt(index);
    // notesList.insert(0, updatedNote);
  }

  // Delete a todo from the database and update the local list
  void deleteTodo(int id) async {
    try {
      await _db.deleteTodo(id);
      todosList.removeWhere((todo) => todo.id == id);
    } catch (e) {
      print('Error deleting todo: $e');
    }
  }

  // Define checkBoxSelected method
  void checkBoxSelected(bool? value, int index) {
    try {
      isChecked.value = value ?? false;
      // Optionally, update the database here
      updateTodo(
        todosList[index].id,
        todosList[index].title,
        todosList[index].date,
        isChecked.value,
      );
    } catch (e) {
      print('Error updating checkbox: $e');
    }
  }
}
