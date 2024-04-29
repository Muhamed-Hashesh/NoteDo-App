import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:intl/intl.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class NoteAndTodoItemCard extends StatefulWidget {
  const NoteAndTodoItemCard({
    super.key,
    required this.noteTitle,
    this.hasContent = true,
    required this.noteContent,
    required this.date,
    required this.isWhiteMode,
    this.leading = false,
    this.isCecked = false,
    required this.onChanged,
  });

  final String noteTitle;
  final bool hasContent;
  final String noteContent;
  final DateTime date;
  final bool isWhiteMode;
  final bool leading;
  final bool isCecked;
  final Function(bool?)? onChanged;

  @override
  State<NoteAndTodoItemCard> createState() => _NoteAndTodoItemCardState();
}

class _NoteAndTodoItemCardState extends State<NoteAndTodoItemCard> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = (widget.isWhiteMode
        ? const Color.fromARGB(255, 214, 214, 214).withOpacity(0.8)
        : const Color.fromARGB(255, 49, 49, 49));
    // super.build(context);
    return Card(
      elevation: 0,
      // color: getRandomColor(),
      color: backgroundColor,
      // color: Color.fromARGB(80, Random().nextInt(100) + 155,
      //     Random().nextInt(100) + 155, Random().nextInt(100) + 155),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: widget.leading
              ? MSHCheckbox(
                  size: 30,
                  value: widget.isCecked,
                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                    checkedColor: Colors.blue,
                  ),
                  style: MSHCheckboxStyle.values[2],
                  onChanged: widget.onChanged!,
                )
              : null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.noteTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isWhiteMode
                      ? Colors.black.withOpacity(0.8)
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              widget.hasContent
                  ? Text(
                      widget.noteContent,
                      style: TextStyle(
                        fontSize: 15,
                        color: widget.isWhiteMode
                            ? Colors.black.withOpacity(0.5)
                            : Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const SizedBox(width: 0, height: 0)
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Edited : ${DateFormat('EEE MMM d, yyyy h:mm a').format(widget.date)}',
              style: TextStyle(
                  color: widget.isWhiteMode
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.6),
                  fontSize: 12),
            ),
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Ionicons.ios_archive_outline,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
