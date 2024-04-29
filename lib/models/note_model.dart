class NoteCardModel {
  final String title;
  final String content;
  final DateTime date;
  final int id;
  final bool hasContent;

  NoteCardModel({
    required this.title,
    required this.content,
    required this.date,
    required this.id,
    this.hasContent = true,
  });
}

List<NoteCardModel> notesList = [
  NoteCardModel(
    id: 0,
    title: 'Homework',
    content:
        'add and do your homework add and do your homework add and do your homework',
    date: DateTime(2024, 1, 1, 34, 5),
    hasContent: true,
  ),
  NoteCardModel(
    id: 1,
    title: 'Tasks',
    content: 'tesks of sections',
    date: DateTime(2024, 1, 1, 34, 5),
    hasContent: true,
  ),
  // NoteCardModel(
  //   id: 2,
  //   title: 'Remindar',
  //   content: 'Don\'t do any thing',
  //   date: DateTime(2024, 1, 1, 34, 5),
  //   hasContent: true,
  // ),
  // NoteCardModel(
  //   id: 3,
  //   title: 'Note name',
  //   content:
  //       'note cotent will be added here later note cotent will be added here later note cotent will be added here later ',
  //   date: DateTime(2024, 1, 1, 34, 5),
  //   hasContent: true,
  // ),
  // NoteCardModel(
  //   id: 4,
  //   title: 'Action',
  //   content: 'no',
  //   date: DateTime(2023, 1, 1, 60, 5),
  //   hasContent: true,
  // ),
];
