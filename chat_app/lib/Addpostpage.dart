import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginpage.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage(this.user);
  final User user;
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String messageText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Post Message'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  onChanged: (String value) {
                    setState(() {
                      messageText = value;
                    });
                  }),
              const SizedBox(height: 8),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('post'),
                    onPressed: () async {
                      final date = DateTime.now().toLocal().toIso8601String();
                      final email = widget.user.email;
                      await FirebaseFirestore.instance
                          .collection('post')
                          .doc()
                          .set({
                        'text': messageText,
                        'email': email,
                        'date': date,
                      });
                      Navigator.of(context).pop();
                    },
                  )),
            ],
          ),
        )));
  }
}
