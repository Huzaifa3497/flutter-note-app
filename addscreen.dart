import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController editController = TextEditingController();

  void addNote() {
    FirebaseFirestore.instance.collection('notes').add({
      'msg': editController.text,
      'title': titleController.text,
    });

    Navigator.pop(context); // Close the add note screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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
              decoration: InputDecoration(labelText: "Add your note"),
            ),
            ElevatedButton(
              onPressed: addNote,
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
