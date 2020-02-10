import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _formKey = GlobalKey<FormState>();
  final contentController = TextEditingController();
  final tagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Write A Message", style: TextStyle(fontSize: 20)),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              controller: tagsController,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                labelText: "Tags (e.g. 'tag1 tag2 tag3')",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.split(" ").length > 5) {
                  return 'Please do not put more than 5 tags';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: contentController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Enter message content",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length >= 140) {
                  return 'Max charachter length is 140';
                }
                return null;
              },
            ),
            FlatButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Firestore.instance.collection('messages').document().setData({
                    'content': contentController.text,
                    'postedBy': 'anonim',
                    'postedTime': Timestamp.now(),
                    'tags': tagsController.text.split(" ").map((f) => f.replaceAll("#", "")).toList()
                  });
                  contentController.clear();
                  tagsController.clear();
                  Navigator.pop(context);
                }
              },
              color: Colors.grey[900],
              child: Text("Write", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
