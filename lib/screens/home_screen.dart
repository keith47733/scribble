import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/note_controller.dart';
import '../data/constants.dart';
import '../widgets/note_content.dart';
import '../widgets/note_date.dart';
import '../widgets/note_title.dart';
import 'add_note_screen.dart';
import 'view_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _gotoAddNote(context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(builder: (context) => const AddNoteScreen()),
        )
        .then((value) => setState((() {})));
  }

  void _gotoViewNote(context, note) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ViewNoteScreen(
              // docRef: docRef,
              note: note,
            ),
          ),
        )
        .then((value) => setState((() {})));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BG_COLOR,
        appBar: _appBar(context, 'Scribbles'),
        body: FutureBuilder(
            future: NoteController.fetchNotesByDate(),
            builder: (ctx2, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('You haven\'t scribbled anything down yet.'),
                );
              }
              return _noteList(ctx2, snapshot);
            }),
        floatingActionButton: _fab(context),
      ),
    );
  }

  Widget _noteList(ctx2, snapshot) {
    return Padding(
      padding: const EdgeInsets.only(
        top: DISPLAY_SPACING / 4,
        left: DISPLAY_SPACING,
        right: DISPLAY_SPACING,
      ),
      child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (ctx2, index) {
            return _noteCard(
              ctx2,
              snapshot.data!.docs[index],
            );
          }),
    );
  }

  Widget _noteCard(ctx2, note) {
    final DateTime date = note['created'].toDate();
    final String formattedDate = DateFormat('MMM d, yyyy  h:mm a').format(date);

    return Padding(
      padding: const EdgeInsets.only(bottom: DISPLAY_SPACING),
      child: InkWell(
        onTap: () => _gotoViewNote(context, note),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(BORDER_RADIUS * 2),
          child: Card(
            color: NOTE_COLORS[note['color']],
            child: Padding(
              padding: const EdgeInsets.all(DISPLAY_SPACING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  noteTitle(ctx2, note['title'], DARK_TEXT),
                  const SizedBox(height: DISPLAY_SPACING),
                  noteContent(ctx2, note['content'], DARK_TEXT),
                  const SizedBox(height: DISPLAY_SPACING),
                  noteDate(ctx2, formattedDate, DARK_TEXT),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(context, title) {
    final auth = FirebaseAuth.instance;
    final imageUrl = auth.currentUser!.photoURL;
    final height = MediaQuery.of(context).size.height;
    const sizeFactor = 0.10;
    return AppBar(
      elevation: 0.0,
      toolbarHeight: height * sizeFactor * 1.2,
      backgroundColor: BG_COLOR,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: LIGHT_TEXT,
          ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              title,
              textScaleFactor: TEXT_SCALE_FACTOR * 2,
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(height * sizeFactor / 2),
              child: Image.network(
                imageUrl!,
                height: height * sizeFactor,
                width: height * sizeFactor,
                fit: BoxFit.cover,
              ),
            ),
          ]),
    );
  }

  Widget _fab(context) {
    return FloatingActionButton.extended(
      onPressed: () {
        _gotoAddNote(context);
      },
      backgroundColor: Colors.black,
      extendedPadding: const EdgeInsets.symmetric(
        vertical: DISPLAY_SPACING * 2,
        horizontal: DISPLAY_SPACING,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      label: const Text('ADD NOTE'),
    );
  }
}
