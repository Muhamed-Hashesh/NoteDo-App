import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/note_model.dart';

class EditNoteController extends GetxController {
  NoteCardModel? noteCardModel;

  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: noteCardModel?.title ?? '');
    contentController =
        TextEditingController(text: noteCardModel?.content ?? '');
  }

  bool canSave() {
    return titleController.text.isNotEmpty || contentController.text.isNotEmpty;
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
