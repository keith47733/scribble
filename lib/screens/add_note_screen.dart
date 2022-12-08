import 'dart:math';

import 'package:flutter/material.dart';

import '../controllers/note_controller.dart';
import '../data/constants.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _colorIndex = Random().nextInt(NOTE_COLORS.length);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _addNote() async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    final navigatorContext = Navigator.of(context);
    String? message;
    try {
      Map<String, dynamic> newNote = {
        'color': _colorIndex,
        'title': _titleController.text,
        'content': _contentController.text,
        'created': DateTime.now(),
      };
      await NoteController.addNote(newNote);
      message = 'The new note was added to your collection.';
    } catch (error) {
      message =
          'Scribbles was unable to add the new note to your collection. Please try again later.';
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
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: NOTE_COLORS[_colorIndex],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(DISPLAY_SPACING),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _backButton(context, _colorIndex),
                  _saveButton(context),
                ],
              ),
              const SizedBox(height: DISPLAY_SPACING * 2),
              Form(
                child: Column(children: [
                  _titleForm(context),
                  const SizedBox(height: DISPLAY_SPACING),
                  _contentForm(context),
                ]),
              )
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

  Widget _saveButton(context) {
    return ElevatedButton(
      onPressed: _addNote,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: DISPLAY_SPACING / 4,
          horizontal: DISPLAY_SPACING / 2,
        ),
        child: Text('SAVE NOTE'),
      ),
    );
  }

  Widget _titleForm(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: TextFormField(
        controller: _titleController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLength: 50,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: 'Enter the title',
            hintStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: DARK_TEXT),
            counterStyle: const TextStyle(color: Colors.black)),
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(color: DARK_TEXT),
      ),
    );
  }

  Widget _contentForm(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      child: TextFormField(
        controller: _contentController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLength: 165,
        maxLines: 10,
        decoration: InputDecoration(
            hintText: 'Enter your note',
            hintStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: DARK_TEXT),
            counterStyle: const TextStyle(color: Colors.black)),
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(color: DARK_TEXT),
      ),
    );
  }
}
