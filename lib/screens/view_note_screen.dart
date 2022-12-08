import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/note_controller.dart';
import '../data/constants.dart';
import '../widgets/note_content.dart';
import '../widgets/note_date.dart';
import '../widgets/note_title.dart';

class ViewNoteScreen extends StatefulWidget {
  const ViewNoteScreen({
    required this.note,
    super.key,
  });

  final QueryDocumentSnapshot note;

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  Future<void> _deleteNote(docRef) async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    final navigatorContext = Navigator.of(context);
    String? message;
    try {
      await NoteController.deleteNote(docRef);
      message = 'The selected note was deleted from your collection.';
    } catch (error) {
      message =
          'Scribbles was unable to delete the selected note from your collection. Please try again later.';
    }
    scaffoldContext.showSnackBar(SnackBar(
      content: Text(
        message,
        textScaleFactor: TEXT_SCALE_FACTOR.toDouble() / 1.8,
      ),
    ));
    navigatorContext.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: NOTE_COLORS[widget.note['color']],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(DISPLAY_SPACING),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _backButton(context, widget.note['color']),
                        _deleteButton(context),
                      ]),
                  const SizedBox(height: DISPLAY_SPACING * 2),
                  _displayNote(context, widget.note),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _backButton(context, colorIndex) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: DISPLAY_SPACING / 4,
          horizontal: DISPLAY_SPACING / 2,
        ),
        child: Text('BACK'),
      ),
    );
  }

  Widget _deleteButton(context) {
    return ElevatedButton(
      onPressed: () => _deleteNote(widget.note.reference),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: DISPLAY_SPACING / 4,
          horizontal: DISPLAY_SPACING / 2,
        ),
        child: Text('DELETE NOTE'),
      ),
    );
  }

  Widget _displayNote(context, note) {
    final DateTime date = note['created'].toDate();
    final String formattedDate = DateFormat('MMM d, yyyy  h:mm a').format(date);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        noteTitle(context, note['title'], DARK_TEXT),
        const SizedBox(height: DISPLAY_SPACING * 1.5),
        noteContent(context, note['content'], DARK_TEXT),
        const SizedBox(height: DISPLAY_SPACING),
        noteDate(context, formattedDate, DARK_TEXT),
      ],
    );
  }
}
