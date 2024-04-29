import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:notedo_app/models/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen(
      {super.key, required this.isWhiteMode, this.noteCardModel});
  final bool isWhiteMode;
  final NoteCardModel? noteCardModel;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  IconData? selectedIcon;

  List<IconData> iconList = [
    MaterialIcons.format_bold,
    MaterialIcons.format_underline,
    MaterialIcons.format_italic,
    LineIcons.alignRight,
    LineIcons.alignLeft,
    LineIcons.alignCenter,
  ];

  @override
  void initState() {
    if (widget.noteCardModel != null) {
      titleController =
          TextEditingController(text: widget.noteCardModel!.title);
      contentController =
          TextEditingController(text: widget.noteCardModel!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(20),
            height: 65,
            decoration: BoxDecoration(
              color: widget.isWhiteMode
                  ? const Color.fromARGB(255, 214, 214, 214).withOpacity(0.8)
                  : const Color.fromARGB(255, 49, 49, 49),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(iconList.length, (index) {
                selectedIcon = iconList[index];
                return IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    iconList[index],
                    size: 24,
                    color: widget.isWhiteMode ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIcon = iconList[index];
                      contentController.text;
                    });
                  },
                );
              }),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              key: const PageStorageKey('*'),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(
                      color: widget.isWhiteMode ? Colors.black : Colors.white,
                      fontSize: 30),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
                ),
                TextField(
                  controller: contentController,
                  style: TextStyle(
                      color: widget.isWhiteMode ? Colors.black : Colors.white),
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(
                context, [titleController.text, contentController.text]),
            child: Container(
              alignment: Alignment.center,
              height: 43,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}