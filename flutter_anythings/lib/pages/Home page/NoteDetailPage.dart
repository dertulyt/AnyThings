import 'package:flutter/material.dart';
import 'package:flutter_anythings/pages/db/AllThingsDatabase.dart';
import 'package:flutter_anythings/pages/model/thing.dart';
import 'package:intl/intl.dart';

class NoteDetailPage extends StatefulWidget {
  final Thing noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  // late Thing thing;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    // this.thing = await AllMyThings.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [deleteButton()],
          title: Text(
            widget.noteId.title,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(widget.noteId.createdTime),
                      style: TextStyle(color: Color.fromARGB(97, 0, 0, 0)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.noteId.subtitle.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(179, 0, 0, 0), fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.noteId.choose.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(179, 0, 0, 0), fontSize: 18),
                    ),
                  ],
                ),
              ),
      );

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await AllMyThings.instance.delete(widget.noteId.id!);

          Navigator.of(context).pop();
        },
      );
}
