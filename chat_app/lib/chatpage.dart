import 'dart:html';

import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'loginpage.dart';
import 'Addpostpage.dart';

class ChatPage extends StatelessWidget {
  ChatPage();
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              // ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(child: Text('login information:${user.email}')),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('post').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView(
                      children: documents.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['text']),
                            subtitle: Text(document['email']),
                            trailing: document['email'] == user.email
                                ? IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('post')
                                          .doc(document.id)
                                          .delete();
                                    },
                                    icon: const Icon(Icons.delete))
                                : null,
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const Center(
                    child: Text('roading'),
                  );
                }),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddPostPage(user);
          }));
        },
      ),
    );
  }
}
