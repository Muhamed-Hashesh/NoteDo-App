import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:notedo_app/views/archived_page.dart';
import 'package:notedo_app/views/notes_screen.dart';
import 'package:notedo_app/views/todo_screen.dart';
import 'package:notedo_app/views/translator_page.dart';

class Sections extends StatelessWidget {
  const Sections({
    super.key,
    required this.listLength,
    required this.listOfContent,
    required this.isWhiteMode,
    this.router,
  });

  final int listLength;
  final List listOfContent;
  final bool isWhiteMode;
  final Widget? router;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: List.generate(
          listLength,
          (index) => GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                // Check the text of the tapped item
                final String text = listOfContent[index]['text'];
                if (text == 'Notes') {
                  return NotesScreen(
                    isWhiteMode: isWhiteMode,
                    hasAppBar: true,
                    title: 'Your Notes',
                  );
                } else if (text == 'Todos') {
                  return TodoScreen(
                    hasAppBar: true,
                    title: 'Your Todos List',
                    isWhiteMode: isWhiteMode,
                  );
                } else if (text == 'Archive') {
                  // Handle other cases, if needed
                  return const ArchivedScreen();
                } else if (text == 'Translate') {
                  // Handle other cases, if needed
                  return TranslatorScreen(isWhiteMode: isWhiteMode);
                } else {
                  return listOfContent[index]['route'];
                }
              }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              color: isWhiteMode
                  ? const Color.fromARGB(255, 214, 214, 214).withOpacity(0.8)
                  : const Color(0xFF1c1d1f),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: listOfContent[index]['color'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            listOfContent[index]['icon'],
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        listOfContent[index]['text'],
                        style: TextStyle(
                          color: isWhiteMode ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    FontAwesome.caret_right,
                    color: isWhiteMode
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.2),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
