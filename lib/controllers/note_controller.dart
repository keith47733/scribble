import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteController {
  static Future<QuerySnapshot> fetchNotesByDate() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
    return await ref.orderBy('created', descending: true).get();
  }

  static Future<void> addNote(newNote) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
    await ref.add(newNote);
  }

  static Future<void> deleteNote(docRef) async {
    await docRef.delete();
  }
}
