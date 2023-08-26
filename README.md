# flutter-note-app
flutter note app with firebase 
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      home: NotesList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
//note screen

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Notes App"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child:
                  CircularProgressIndicator(), // Loading indicator at the center
            ); // Loading indicator
          }

          final notes = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final noteId = notes[index].id;
              final note = notes[index]['msg'];
              final noteTitle = notes[index]['title'];

              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Note"),
                        content:
                            Text("Are you sure you want to delete this note?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('notes')
                                  .doc(noteId)
                                  .delete();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNoteScreen(
                        noteId: noteId,
                        currentNote: note,
                        currentTitle: noteTitle,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noteTitle,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(note),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
//add note screen

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
//edit screen

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

