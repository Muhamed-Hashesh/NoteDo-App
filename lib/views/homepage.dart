import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:notedo_app/json/todo_list_model.dart';
import 'package:notedo_app/models/note_model.dart';
import 'package:notedo_app/views/edit_note_screen.dart';
import 'package:notedo_app/views/notes_screen.dart';
import 'package:notedo_app/views/todo_screen.dart';
import 'package:notedo_app/widgets/custom_button.dart';
import 'package:notedo_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.changeAppTheme, required this.isWhiteMode});

  final Function() changeAppTheme;

  final bool isWhiteMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tabsList = [
    'Notes',
    'Todos',
  ];
  final TextEditingController _titleController = TextEditingController();

  List noteListFitched = [];
  // List todoListFitched = [];

  int currentIndex = 0;
  String title = 'Notes';
  String floatingButtonText = 'Add Note';

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return DefaultTabController(
      length: tabsList.length,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            // style: const TextStyle(color: Colors.black),
          ),
          toolbarHeight: 80,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.sort,
                // color: Colors.black,
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          // backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(66),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade100,
                ),
                child: TabBar(
                  onTap: (value) {
                    setState(() {
                      title = tabsList[value];
                      currentIndex = value;
                      floatingButtonText =
                          'Add ${(tabsList[value]).substring(0, (tabsList[value]).length - 1)}';
                    });
                  },
                  dividerHeight: 0,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  indicator: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: List.generate(
                    tabsList.length,
                    (index) {
                      // currentIndex = index;
                      return Tab(
                        child: Text(
                          tabsList[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Ionicons.ios_moon),
                onPressed: widget.changeAppTheme,
                tooltip: 'change theme',
              ),
            )
          ],
        ),
        drawer: CustomDrawer(
          isWhiteMode: widget.isWhiteMode,
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NotesScreen(
                isWhiteMode: widget.isWhiteMode,
              ),
              TodoScreen(
                isWhiteMode: widget.isWhiteMode,
              ),
            ]),
        floatingActionButton: getFloatingActionButton(),
      ),
    );
  }

  getFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () async {
        if (tabsList[currentIndex] == 'Notes') {
          var noteContent = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return EditNoteScreen(isWhiteMode: widget.isWhiteMode);
          }));
          if (noteContent != null) {
            setState(() {
              notesList.insert(
                0,
                NoteCardModel(
                  title: noteContent[0],
                  content: noteContent[1],
                  date: DateTime.now(),
                  id: notesList.length,
                  hasContent: true,
                ),
              );
              // noteListFitched = notesList;
            });
          }
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon: const Icon(Ionicons.ios_add_circle,
                      size: 50, color: Colors.green),
                  title: const Text(
                    'Add Todo Task',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        style: TextStyle(
                            color: widget.isWhiteMode
                                ? Colors.black
                                : Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyCustomElevatedButton(
                            onPresssed: () => Navigator.pop(context),
                            label: 'Cancle',
                            btnColor: Colors.red,
                          ),
                          MyCustomElevatedButton(
                            onPresssed: () {
                              setState(() {
                                _titleController.text.isEmpty
                                    ? null
                                    : todoTasksList.insert(0, [
                                        _titleController.text,
                                        DateTime.now(),
                                        false
                                      ]);
                              });

                              _titleController.clear();
                              Navigator.of(context).pop();
                            },
                            label: 'Add',
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        }
      },
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      icon: const Icon(Ionicons.ios_create_outline),
      tooltip: 'create new task',
      label: Text(floatingButtonText),
    );
  }
}
