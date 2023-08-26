import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteId;
  final String currentNote;
  final String currentTitle;

  EditNoteScreen(
      {required this.noteId,
      required this.currentNote,
      required this.currentTitle});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.currentTitle;
    editController.text = widget.currentNote;

    // Listen to changes in the text fields and update Firestore whenever there's a change
    titleController.addListener(updateNote);
    editController.addListener(updateNote);
  }

  void updateNote() {
    FirebaseFirestore.instance.collection('notes').doc(widget.noteId).update({
      'msg': editController.text,
      'title': titleController.text,
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Note Title"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: editController,
              maxLines: null,
              decoration: InputDecoration(labelText: "Edit your note"),
            ),
          ],
        ),
      ),
    );
  }
}
