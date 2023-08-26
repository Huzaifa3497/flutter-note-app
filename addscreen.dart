import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController editController = TextEditingController();

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
              onChanged: (text) {
                addNote(); // Call the addNote function whenever text changes
              },
            ),
          ],
        ),
      ),
    );
  }

  void addNote() {
    FirebaseFirestore.instance.collection('notes').add({
      'msg': editController.text,
      'title': titleController.text,
    });
  }
}
